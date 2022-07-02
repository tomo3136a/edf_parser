// #define DEBUG

using System;
using System.Collections.Generic;
using System.IO;
using System.Diagnostics;
using System.Windows.Forms;

namespace hwutils
{
    public partial class App : ConsoleForm
    {
        string app_name;
        string[] app_args;

        List<string> edf_lst = new List<string>() { ".edf", ".edif" };
        List<string> csv_lst = new List<string>() { ".csv", ".bom" };

        Dictionary<string, string> opt = new Dictionary<string, string>() { };
        Dictionary<string, string> col = new Dictionary<string, string>() { };
        List<string> src_lst = new List<string>();
        List<string> xsl_lst = new List<string>();

        public App(string name, string[] args)
        {
            app_name = name;
            app_args = args;
        }

        private void SetParam(string arg)
        {
            if (arg[0] == '-') {
                string[] ss = (arg + "=").Split('=');
                if (opt.ContainsKey(ss[0])) opt.Remove(ss[0]);
                opt.Add(ss[0], ss[1]);
            }
            else if (arg.Contains("=")) {
                string[] ss = (arg + "=").Split('=');
                if (col.ContainsKey(ss[0])) col.Remove(ss[0]);
                col.Add(ss[0], ss[1]);
            }
            else if (arg.EndsWith(".xsl")) { xsl_lst.Add(arg); }
            else { src_lst.Add(arg); }
        }

        private string GetSource(string path)
        {
            string src = path;
            string s = path.ToLower();
            foreach (string ext in edf_lst) {
                if (s.EndsWith(ext)) {
                    src = Path.ChangeExtension(path, ".xedf");
                    if (!Edif2Xml(path, src)) 
                        MessageBox.Show("not find: " + path);
                    return src;
                }
            }
            foreach (string ext in csv_lst) {
                if (s.EndsWith(ext)) {
                    src = Path.ChangeExtension(path, ".xdata");
                    if (!Csv2Xml(path, src)) 
                        MessageBox.Show("not find: " + path);
                    return src;
                }
            }
            return src;
        }

        public override long Run()
        {
            string ini = app_name + ".ini";
            foreach (string arg in app_args) SetParam(arg);

            // input setting file
            if (opt.ContainsKey("-i")) {
                if (opt["-i"].Length > 0) ini = opt["-i"];
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
                Console.WriteLine("source: " + Path.GetFileName(arg));
                string src = GetSource(arg);
                foreach (string xsl in xsl_lst) {
                    Xslt(src, xsl, GetDestName(src, xsl), col);
                }
                if (xsl_lst.Count == 0) Execute(src, col);
            }

            // output setting file
            if (opt.ContainsKey("-o")) {
                if (opt["-o"].Length > 0) ini = opt["-o"];
                Console.WriteLine("save setting: " + ini);
                using (StreamWriter wrt = new StreamWriter(ini)) {
                    foreach (string src in src_lst)
                        wrt.WriteLine(src);
                    foreach (string xsl in xsl_lst)
                        wrt.WriteLine(xsl);
                    foreach (string k in col.Keys)
                        wrt.WriteLine(k + "=" + col[k]);
                }
            }
            return 0;
        }

        ////////////////////////////////////////////////////////////////////////////////

        [STAThread]
        public static void Main(string[] args)
        {
            var p = @".\\debug.txt";
            ((DefaultTraceListener)Debug.Listeners["Default"]).LogFileName = p;
            Debug.WriteLine(DateTime.Now.ToString("> yyyy/MM/dd HH:mm:ss"));
            try
            {
                p = Environment.GetCommandLineArgs()[0].Replace(".exe", "");
                p = Path.GetFileNameWithoutExtension(p);
                AppDomain.CurrentDomain.SetData("APP_CONFIG_FILE", p + ".config");
                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);
                Application.Run(new App(p, args));
            }
            catch (Exception e) { MessageBox.Show(e.ToString()); }
            Debug.Flush();
        }
    }
}
