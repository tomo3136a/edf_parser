#define DEBUG

using System;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using System.Xml.Xsl;
using System.Diagnostics;
using System.Windows.Forms;

namespace hwutils
{
    using MsgBox = System.Windows.Forms.MessageBox;

    public class App : ConsoleForm
    {
        string app_name;
        string[] app_args;

        readonly EdifXmlDocument edifxml = new EdifXmlDocument();

        public App(string name, string[] args)
        {
            app_name = name;
            app_args = args;
        }

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

        public bool Csv2Xml(XmlDocument doc, string src)
        {
            XmlElement root = doc.CreateElement("data");
            foreach (string line in File.ReadAllLines(src)) {
                XmlElement dl = doc.CreateElement("dl");
                foreach (string v in line.Split(',')) {
                    XmlElement dd = doc.CreateElement("dd");
                    dd.InnerText = v;
                    dl.AppendChild(dd);
                }
                root.AppendChild(dl);
            }
            doc.AppendChild(root);
            return true;
        }

        public bool List2Xml(XmlDocument doc, string src)
        {
            XmlElement root = doc.CreateElement("data");
            XmlElement dl = doc.CreateElement("dl");
            foreach (string line in File.ReadAllLines(src)) {
                XmlElement dd = doc.CreateElement("dd");
                dd.InnerText = line;
                dl.AppendChild(dd);
            }
            root.AppendChild(dl);
            doc.AppendChild(root);
            return true;
        }

        // xslt transformation
        public void Xslt(string src, string xsl, string dst, Dictionary<string, string> col)
        {
            var tm = new System.Diagnostics.Stopwatch();
            tm.Start();
            XslCompiledTransform trans = new XslCompiledTransform();
            XmlWriterSettings ws = new XmlWriterSettings();
            XsltArgumentList al = new XsltArgumentList();
            trans.Load(xsl);
            foreach (string k in col.Keys) {
                string v = col[k];
                if (k[0] == '@') {
                    if (!File.Exists(v)){
                        Console.WriteLine("not find: "+v);
                        continue;
                    }
                    XmlDocument doc = new XmlDocument();
                    string ext = Path.GetExtension(v);
                    if (ext == ".txt") Csv2Xml(doc, v);
                    else if (ext == ".csv") Csv2Xml(doc, v);
                    else doc.Load(v);
                    al.AddParam(k.Substring(1), "", doc);
                    continue;
                }
                al.AddParam(k, "", v);
            }
            ws.ConformanceLevel = ConformanceLevel.Fragment;
            XmlWriter wrt = XmlWriter.Create(dst, ws);
            trans.Transform(src, al, wrt);
            wrt.Close();
            tm.Stop();
            Console.Write(":xsl: "+Path.GetFileNameWithoutExtension(dst));
            Console.WriteLine(" : "+tm.ElapsedMilliseconds+"ms");
        }

        // public void Format(string src, string dst)
        //   {
        //     XmlDocument doc = new XmlDocument();
        //     doc.Load(src);
        //     doc.Save(dst);
        // }

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

        /////////////////////////////////////////////////////////////////////////////

        List<string> src_lst = new List<string>();
        List<string> xsl_lst = new List<string>();
        Dictionary<string, string> opt = new Dictionary<string, string>() { };
        Dictionary<string, string> col = new Dictionary<string, string>() { };

        private void SetParam(string arg)
        {
            if (arg[0] == '-'){
                string[] ss = (arg + "=").Split('=');
                if (opt.ContainsKey(ss[0])) opt.Remove(ss[0]);
                opt.Add(ss[0], ss[1]);
            }
            else if (arg.Contains("=")) {
                string[] ss = (arg + "=").Split('=');
                if (col.ContainsKey(ss[0])) col.Remove(ss[0]);
                col.Add(ss[0], ss[1]);
            }
            else if (arg.Contains(".xsl")){ xsl_lst.Add(arg); }
            else { src_lst.Add(arg); }
        }

        public override long Run()
        {
            string ini = app_name+".ini";

            // parse command line
            foreach (string arg in app_args) SetParam(arg);

            // input setting file
            if (opt.ContainsKey("-i")) {
                if (opt["-i"].Length>0) ini = opt["-i"];
                Console.WriteLine("load setting: " + ini);
                using (StreamReader rdr = new StreamReader(ini))
                {
                    src_lst.Clear();
                    xsl_lst.Clear();
                    col.Clear();
                    string arg;
                    while ((arg = rdr.ReadLine()) != null) SetParam(arg);
                }
            }

            // setting dialog
            if (opt.ContainsKey("-s")) {
                SettingDialog dlg = new SettingDialog(app_name);
                dlg.SetData(src_lst, xsl_lst, col);
                if (dlg.ShowDialog() != DialogResult.OK)
                     return -1;
                dlg.Restore();
            }
    
            foreach (string arg in src_lst)
            {
                string src = arg + ".xml";
                if (arg.Contains(".edf")){ src = arg.Replace(".edf", ".xedf"); }
                if (arg.Contains(".edif")){ src = arg.Replace(".edif", ".xedf"); }
                Console.WriteLine(">" + Path.GetFileName(arg));
                if (arg.Contains(".xedf")){ src = arg; }
                else if (!Edif2Xml(arg, src)) {
                    MsgBox.Show("not find: " + arg);
                    continue;
                }
                foreach (string xsl in xsl_lst) {
                    Xslt(src, xsl, GetDestName(src, xsl), col);
                }
                if (xsl_lst.Count == 0) Execute(src, col);
            }

            // output setting file
            if (opt.ContainsKey("-o")) {
                if (opt["-o"].Length>0) ini = opt["-o"];
                Console.WriteLine("save setting: " + ini);
                using (StreamWriter wrt = new StreamWriter(ini)) {
                    foreach (string src in src_lst)
                        wrt.WriteLine(src);
                    foreach (string xsl in xsl_lst)
                        wrt.WriteLine(xsl);
                    foreach (string k in col.Keys)
                        wrt.WriteLine(k+"="+col[k]);
                }
            }
            return 0;
        }

        /////////////////////////////////////////////////////////////////////////////

        private static void SetDebugLogFileName(string path = @".\\debug.txt")
        {
            var p = Debug.Listeners["Default"];
            ((DefaultTraceListener)p).LogFileName = path;
        }

        [STAThread]
        public static void Main(string[] args)
        {
            SetDebugLogFileName();
            Debug.WriteLine(DateTime.Now.ToString("> yyyy/MM/dd HH:mm:ss"));
            try
            {
                string name = Environment.GetCommandLineArgs()[0].Replace(".exe", "");
                string config = name + ".config";
                name = Path.GetFileNameWithoutExtension(name);
                AppDomain.CurrentDomain.SetData("APP_CONFIG_FILE", config);
                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);
                Application.Run(new App(name, args));
            }
            catch (Exception e) { MsgBox.Show(e.ToString()); }
            Debug.Flush();
        }
    }
}
