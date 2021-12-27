using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows.Forms;
using System.Xml;
using System.Xml.Xsl;

namespace hwutil
{
    public class Application
    {
        public string msg = "error : ";

        readonly List<string> sn = new List<string>() { "name", "rename" };
        readonly List<string> nm = new List<string>() {
            "edif", "design", "external", "library", "cell", "view", "page",
            "instance", "portInstance", "port", "portBundle", "portListAlias",
            "portImplementation",
            "viewRef", "portRef", "instanceRef", "cellRef", "libraryRef",
            "figureGroup", "figureGroupOverride", "figure", "offpageConnector",
            "net", "netBundle", "property", "parameter", "display", "keywordDisplay"
        };
        enum PS { S0, S1, S2, S3, S4 };
        XmlDocument doc;
        XmlNode node;
        PS seq;
        public void InitParse()
        {
            doc = new XmlDocument();
            doc.AppendChild(doc.CreateXmlDeclaration("1.0", null, null));
            node = doc;
            seq = PS.S0;
        }
        public string Parse(string s)
        {
            if (s.Length <= 0) { return ""; }
            if (s == "(") { seq = PS.S0; return ""; }
            if (s == ")") { node = node.ParentNode; seq = PS.S3; return ""; }
            switch (seq)
            {
                case PS.S0:
                    node = node.AppendChild(doc.CreateNode("element", s.ToLower(), null));
                    if (nm.Contains(s)) { seq = PS.S1; break; }
                    if (sn.Contains(s)) { seq = PS.S2; } else { seq = PS.S3; }
                    break;
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

        enum TK { EXP, STR, STR2 };
        public void LoadEdif(string src, string enc = "Shift_JIS")
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

        public bool Edif2Xml(string src, string dst, string encoding = "Shift_JIS")
        {
            if (!File.Exists(src)) { msg = "not find: " + src; return false; }
            if (File.Exists(dst))
            {
                DateTime src_dt = File.GetLastWriteTime(src);
                DateTime dst_dt = File.GetLastWriteTime(dst);
                if (dst_dt > src_dt) { return true; }
            }
            LoadEdif(src, encoding);
            doc.Save(dst);
            return true;
        }

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
            doc = new XmlDocument();
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
            Application app = new Application();
            string enc = "shift_jis";   // utf-8, shift_jis, euc-jp
            foreach (string arg in args)
            {
                if (arg.StartsWith("-E=")) { enc = arg.Substring(3); }
            }
            try
            {
                Regex re = new Regex("\\.ed[ifs]+$");
                foreach (string arg in args)
                {
                    if (arg.StartsWith("-")) { continue; }
                    string src = arg + ".xml";
                    Match m = re.Match(Path.GetExtension(arg));
                    if (m.Success && !app.Edif2Xml(arg, src, enc))
                        MessageBox.Show(app.msg);
                    app.Xml2Svg(src);
                }
            }
            catch
            {
                MessageBox.Show("error.");
            }
        }
    }
}
