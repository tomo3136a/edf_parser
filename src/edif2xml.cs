using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Text;
using System.Xml;
using System.Xml.Xsl;

namespace hwutil
{
    using MsgBox = System.Windows.Forms.MessageBox;
    public class EdifXmlDocument
    {
        readonly string[] nms = {
            "edif", "design", "external", "library", "cell", "view", "page",
            "instance", "portInstance", "port", "portBundle", "portListAlias",
            "portImplementation",
            "viewRef", "portRef", "instanceRef", "cellRef", "libraryRef",
            "figureGroup", "figureGroupOverride", "figure", "offpageConnector",
            "net", "netBundle", "property", "parameter", "display", "keywordDisplay"
        };
        readonly string[] sns = { "name", "rename" };
        readonly Dictionary<string, string> nm = new Dictionary<string, string>();
        readonly Dictionary<string, string> sn = new Dictionary<string, string>();
        enum PS { S0, S1, S2, S3, S4 };
        enum TK { EXP, STR, STR2 };
        XmlDocument doc;
        XmlNode node;
        PS seq;
        void InitParse()
        {
            foreach (string s in nms) { this.nm.Add(s.ToLower(), s); }
            foreach (string s in sns) { this.sn.Add(s.ToLower(), s); }
            doc = new XmlDocument();
            doc.AppendChild(doc.CreateXmlDeclaration("1.0", null, null));
            node = doc;
            seq = PS.S0;
        }
        string Parse(string s)
        {
            if (s.Length <= 0) { return ""; }
            if (s == "(") { seq = PS.S0; return ""; }
            if (s == ")") { node = node.ParentNode; seq = PS.S3; return ""; }
            string sl = s.ToLower();
            switch (seq)
            {
                case PS.S0:
                    node = node.AppendChild(doc.CreateNode("element", sl, null));
                    if (nm.ContainsKey(sl)) { seq = PS.S1; break; }
                    if (sn.ContainsKey(sl)) { seq = PS.S2; break; }
                    seq = PS.S3; break;
                case PS.S1: ((XmlElement)node).SetAttribute("name", s); seq = PS.S4; break;
                case PS.S2: ((XmlElement)node.ParentNode).SetAttribute("name", s); seq = PS.S3; break;
                case PS.S3: node.AppendChild(doc.CreateTextNode(s)); seq = PS.S4; break;
                case PS.S4:
                    node.AppendChild(doc.CreateWhitespace(" "));
                    node.AppendChild(doc.CreateTextNode(s));
                    break;
                default: break;
            }
            return "";
        }
        void LoadEdif(string src, string enc)
        {
            InitParse();
            using (StreamReader sr = new StreamReader(src, Encoding.GetEncoding(enc)))
            {
                TK seq = TK.EXP;
                string line, s = "";
                while ((line = sr.ReadLine()) != null)
                {
                L1: foreach (char c in line.TrimStart(new char[] { ' ' }))
                        switch (seq)
                        {
                            case TK.EXP:
                                switch (c)
                                {
                                    case '#': case ';': s = Parse(s); goto L1;
                                    case '(': case ')': s = Parse(s); Parse("" + c); break;
                                    case ' ': case '\t': s = Parse(s); break;
                                    case '\"': s = Parse(s) + c; seq = TK.STR; break;
                                    default: s += c; break;
                                }
                                break;
                            case TK.STR:
                                s += c;
                                if (c == '\"') { s = Parse(s); seq = TK.EXP; }
                                else if (c == '\\') { seq = TK.STR2; }
                                break;
                            case TK.STR2:
                                s += c;
                                seq = TK.STR;
                                break;
                            default:
                                break;
                        }
                    if (seq == TK.STR) { s += '\n'; }
                }
                Parse(s);
            }
        }
        public bool Execute(string src, string dst)
        {
            if (!File.Exists(src)) { return false; }
            if (File.Exists(dst))
            {
                DateTime src_dt = File.GetLastWriteTime(src);
                DateTime dst_dt = File.GetLastWriteTime(dst);
                if (dst_dt > src_dt) { return true; }
            }
            string encoding = ConfigurationManager.AppSettings["encoding"];
            // encoding: utf-8, shift_jis, euc-jp
            LoadEdif(src, encoding ?? "shift_jis");
            doc.Save(dst);
            return true;
        }
    }

    public class Application
    {
        readonly EdifXmlDocument edifxml = new EdifXmlDocument();

        public bool Edif2Xml(string src, string dst) { return edifxml.Execute(src, dst); }

        // xslt transformation
        public void Xslt(string src, string xslt, string dst, Dictionary<string, string> col)
        {
            XslCompiledTransform trans = new XslCompiledTransform();
            XsltArgumentList al = new XsltArgumentList();
            XmlWriterSettings ws = new XmlWriterSettings();
            trans.Load(xslt);
            foreach (string k in col.Keys) { al.AddParam(k, "", col[k]); }
            ws.ConformanceLevel = ConformanceLevel.Fragment;
            XmlWriter wrt = XmlWriter.Create(dst, ws);
            trans.Transform(src, al, wrt);
            wrt.Close();
        }

        public void Format(string src, string dst)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load(src);
            doc.Save(dst);
        }

        public void Xml2Svg(string src)
        {
            string cd = Directory.GetCurrentDirectory();
            string xsl_dir = Path.Combine(cd, "xsl");

            src = Path.GetFullPath(src);
            string dir = Path.GetDirectoryName(src);
            string res_dir = Path.Combine(dir, "result");
            if (!Directory.Exists(res_dir))
                Directory.CreateDirectory(res_dir);

            var col = new Dictionary<string, string>() { };
            foreach (string k in Directory.EnumerateFiles(xsl_dir, "edif_*.xsl"))
            {
                string xsl = Path.Combine(xsl_dir, k);
                string s = Path.GetFileNameWithoutExtension(k);
                if (!s.Contains(".")) s += ".lst";
                string dst = Path.Combine(res_dir, s);
                Xslt(src, xsl, dst, col);
            }
            string lst = Path.Combine(res_dir, "edif_page.lst");
            foreach (string page in File.ReadAllLines(lst))
            {
                col = new Dictionary<string, string>() { };
                col.Add("page", page);
                foreach (string k in Directory.EnumerateFiles(xsl_dir, "page_*.xsl"))
                {
                    string xsl = Path.Combine(xsl_dir, k);
                    string s = Path.GetFileNameWithoutExtension(k);
                    s = s.Replace("page_", page + "_");
                    if (!s.Contains(".")) s += ".lst";
                    string dst = Path.Combine(res_dir, s);
                    Xslt(src, xsl, dst, col);
                }
                string name = Path.GetFileNameWithoutExtension(src);
                string in_path = Path.Combine(res_dir, page + "_svg.lst");
                string out_path = Path.Combine(dir, name + "_" + page + ".svg");
                Format(in_path, out_path);
            }
        }

        public static void Main(string[] args)
        {
            try
            {
                string config = Environment.GetCommandLineArgs()[0].Replace(".exe", ".config");
                AppDomain.CurrentDomain.SetData("APP_CONFIG_FILE", config);
                Application app = new Application();
                foreach (string arg in args)
                {
                    string src = arg + ".xml";
                    if (!app.Edif2Xml(arg, src)) { MsgBox.Show("not find: " + src); continue; }
                    app.Xml2Svg(src);
                }
            }
            catch (Exception e) { MsgBox.Show(e.ToString()); }
        }
    }
}
