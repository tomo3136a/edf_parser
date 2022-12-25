using System;
using System.Collections.Generic;
using System.IO;
using System.Diagnostics;
using System.Windows.Forms;
using Document.Pdf;

namespace Program
{
    public partial class App
    {
        string app_name;
        string[] app_args;

        Dictionary<string, string> opt_map = new Dictionary<string, string>() { };
        Dictionary<string, string> col_map = new Dictionary<string, string>() { };
        List<string> src_lst = new List<string>();

        string ini_file;
        int run_mode;

        public App(string name, string[] args)
        {
            app_name = name;
            app_args = args;
            run_mode = 0;
        }

        private bool ParseParam(string arg)
        {
            if (arg[0] == '-') {
                string[] ss = (arg + "=").Split('=');
                if (ss.Length == 2) {
                    run_mode = -Int32.Parse(ss[0]);
                    return true;
                }
                if (opt_map.ContainsKey(ss[0])) opt_map.Remove(ss[0]);
                opt_map.Add(ss[0], ss[1]);
                return true;
            }
            if (arg.Contains("=")) {
                string[] ss = (arg + "=").Split('=');
                if (col_map.ContainsKey(ss[0])) col_map.Remove(ss[0]);
                col_map.Add(ss[0], ss[1]);
                return true;
            }
            src_lst.Add(arg);
            return true;
        }

        public bool Init()
        {
            ini_file = app_name + ".ini";
            foreach (string arg in app_args) ParseParam(arg);
            return true;
        }

        public bool Run()
        {
            foreach (var src in src_lst) {
                PdfDoc doc = new PdfDoc(src);
                // if (! doc.ReadXref(run_mode)) {
                //     continue;
                // }
                // doc.PrintStatus();
                if (! doc.ReadTest(run_mode)) {
                    Console.WriteLine("Error: ReadTest("+src+", "+run_mode+")");
                    continue;
                }
            }
            return true;
        }

        [STAThread]
        public static void Main(string[] args)
        {
            var p = @".\\debug.txt";
            ((DefaultTraceListener)Debug.Listeners["Default"]).LogFileName = p;
            Debug.WriteLine(DateTime.Now.ToString("> yyyy/MM/dd HH:mm:ss"));
            DateTime stime = DateTime.Now;
            try
            {
                p = Environment.GetCommandLineArgs()[0].Replace(".exe", "");
                p = Path.GetFileNameWithoutExtension(p);
                AppDomain.CurrentDomain.SetData("APP_CONFIG_FILE", p + ".config");
                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);
                App app = new App(p, args);
                if(app.Init()) app.Run();
            }
            catch (Exception e) { MessageBox.Show(e.ToString()); }
            Console.WriteLine("\n"+(DateTime.Now - stime));
            Debug.Flush();
        }
    }
}
