#define DEBUG

using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Text;
using System.Xml;
using System.Xml.Xsl;
using System.Diagnostics;
using System.Windows.Forms;

namespace hwutils
{
    using MsgBox = System.Windows.Forms.MessageBox;

    public class Application
    {
        readonly EdifXmlDocument edifxml = new EdifXmlDocument();

        public string GetDestName(string src, string xsl)
        {
            string dst = Path.GetFileNameWithoutExtension(xsl);
            return (Path.HasExtension(dst)) ? dst : (dst + ".txt");
        }

        public bool Edif2Xml(string src, string dst)
        {
            bool res = true;
            if(File.GetLastWriteTime(src) > File.GetLastWriteTime(dst)) {
                var tm = new System.Diagnostics.Stopwatch();
                tm.Start();
                res = edifxml.Execute(src, dst);
                tm.Stop();
                string s = Path.GetFileNameWithoutExtension(src);
                Console.WriteLine(":edif2xml: "+s+" : "+tm.ElapsedMilliseconds+"ms");
            }
            return res;
        }

        public bool List2Xml(XmlDocument doc, string src)
        {
            XmlDeclaration decl = doc.CreateXmlDeclaration(@"1.0", @"utf-8", null);
            XmlElement root = doc.CreateElement("data");
            XmlElement dl = doc.CreateElement("dl");
            foreach (string line in File.ReadAllLines(src)) {
                XmlElement dd = doc.CreateElement("dd");
                dd.InnerText = line;
                dl.AppendChild(dd);
            }
            root.AppendChild(dl);
            doc.AppendChild(decl);
            doc.AppendChild(root);
            return true;
        }

        // xslt transformation
        public void Xslt(string src, string xslt, string dst, Dictionary<string, string> col)
        {
            var tm = new System.Diagnostics.Stopwatch();
            tm.Start();
            XslCompiledTransform trans = new XslCompiledTransform();
            XmlWriterSettings ws = new XmlWriterSettings();
            XsltArgumentList al = new XsltArgumentList();
            trans.Load(xslt);
            foreach (string k in col.Keys) {
                string v = col[k];
                if (k[0] == '@') {
                    if (!File.Exists(v)){
                        Console.WriteLine("not find: "+v);
                        continue;
                    }
                    XmlDocument doc = new XmlDocument();
                    if (Path.GetExtension(v) == ".txt") List2Xml(doc, v);
                    else doc.Load(v);
                    al.AddParam(k.Substring(1), "", doc);
                }
                else{
                    al.AddParam(k, "", v);
                }
            }
            ws.ConformanceLevel = ConformanceLevel.Fragment;
            XmlWriter wrt = XmlWriter.Create(dst, ws);
            trans.Transform(src, al, wrt);
            wrt.Close();
            tm.Stop();
            Console.Write(":xslt: "+Path.GetFileNameWithoutExtension(dst));
            Console.WriteLine(" : "+tm.ElapsedMilliseconds+"ƒ~ƒŠ•b");
        }

        public void Format(string src, string dst)
          {
            XmlDocument doc = new XmlDocument();
            doc.Load(src);
            doc.Save(dst);
        }

        public void Execute(string src, Dictionary<string, string> col)
        {
            string cd = Directory.GetCurrentDirectory();
            string xsl_dir = Path.Combine(cd, "xsl");

            src = Path.GetFullPath(src);
            string dir = Path.GetDirectoryName(src);
            string res = Path.GetFileNameWithoutExtension(src);
            string res_dir = Path.Combine(dir, res);
            if (!Directory.Exists(res_dir))
                Directory.CreateDirectory(res_dir);

            foreach (string k in Directory.EnumerateFiles(xsl_dir, "edif_*.xsl"))
            {
                string xsl = Path.Combine(xsl_dir, k);
                string dst = Path.Combine(res_dir, GetDestName(src, xsl));
                Xslt(src, xsl, dst, col);
            }

            string lst = Path.Combine(res_dir, "edif_page.lst");
            if (!File.Exists(lst)) return;
            foreach (string page in File.ReadAllLines(lst)) {
                col = new Dictionary<string, string>() { };
                col.Add("page", page);
                foreach (string k in Directory.EnumerateFiles(xsl_dir, "page_*.xsl"))
                {
                    string xsl = Path.Combine(xsl_dir, k);
                    string dst = GetDestName(src, xsl).Replace("page_", page + "_");
                    Xslt(src, xsl, Path.Combine(res_dir, dst), col);
                }
                // string name = Path.GetFileNameWithoutExtension(src);
                // string in_path = Path.Combine(res_dir, page + "_svg.lst");
                // string out_path = Path.Combine(dir, name + "_" + page + ".svg");
                // Format(in_path, out_path);
            }
        }

        private static void SetDebugLogFileName(string path)
        {
            var p = Debug.Listeners["Default"];
            ((DefaultTraceListener)p).LogFileName = path;
        }

        // private static void SetConsole(string path)
        // {
        //     var p = Console.Listeners["Default"];
        //     ((DefaultTraceListener)p).LogFileName = path;
        // }

        [STAThread]
        public static void Main(string[] args)
        {
            SetDebugLogFileName(@".\\debug.txt");
            Debug.WriteLine("test debug");
            try
            {
                string config = Environment.GetCommandLineArgs()[0].Replace(".exe", ".config");
                AppDomain.CurrentDomain.SetData("APP_CONFIG_FILE", config);
                Application app = new Application();
                List<string> src_lst = new List<string>();
                List<string> xsl_lst = new List<string>();
                List<string> opt_lst = new List<string>();
                var col = new Dictionary<string, string>() { };

                foreach (string arg in args)
                {
                    if (arg[0] == '-'){ opt_lst.Add(arg); }
                    else if (arg.Contains(".xsl")){ xsl_lst.Add(arg); }
                    else if (arg.Contains("=")) {
                        string[] ss = arg.Split('=');
                        col.Add(ss[0], ss[1]);
                    }
                    else { src_lst.Add(arg); }
                }

                foreach (string opt in opt_lst)
                {
                    if (opt == "-gui") {
                        SetupDialog dlg = new SetupDialog("edif2xml");
                        dlg.SetUp(src_lst, xsl_lst, opt_lst, col);
                        if (dlg.ShowDialog() != DialogResult.OK)
                            return;
                        dlg.Restore();
                    }
                }

                foreach (string arg in src_lst)
                {
                    string src = arg + ".xml";
                    if (arg.Contains(".edf")){ src = arg.Replace(".edf", ".xedf"); }
                    if (arg.Contains(".edif")){ src = arg.Replace(".edif", ".xedf"); }
                    Console.WriteLine(Path.GetFileName(arg));
                    if (arg.Contains(".xedf")){ src = arg; }
                    else if (!app.Edif2Xml(arg, src)) {
                        MsgBox.Show("not find: " + arg);
                        continue;
                    }
                    foreach (string xsl in xsl_lst) {
                        app.Xslt(src, xsl, app.GetDestName(src, xsl), col);
                    }
                    if (xsl_lst.Count == 0) {
                        app.Execute(src, col);
                    }
                }
                MsgBox.Show("Successed");
            }
            catch (Exception e) { MsgBox.Show(e.ToString()); }
            Debug.Flush();
        }
    }
}
