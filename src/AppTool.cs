using System;
using System.Collections.Generic;
using System.IO;
using System.Xml;
using System.Xml.Xsl;

namespace hwutils
{
    public partial class App
    {
        readonly EdifXmlDocument edifxml = new EdifXmlDocument();

        public string GetDestName(string src, string s)
        {
            string dst = Path.GetFileNameWithoutExtension(s);
            return (Path.HasExtension(dst)) ? dst : (dst + ".txt");
        }

        public bool Edif2Xmldoc(XmlDocument doc, string src)
        {
            return edifxml.ConvertToXmldoc(doc, src);
        }

        public bool Csv2Xmldoc(XmlDocument doc, string src)
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

        private string ConvertToXml(string src, string ext, string name)
        {
            string dst = Path.ChangeExtension(src, ext);
            if (!File.Exists(src)) { return ""; }
            if (File.Exists(dst))
            {
                DateTime src_dt = File.GetLastWriteTime(src);
                DateTime dst_dt = File.GetLastWriteTime(dst);
                if (dst_dt > src_dt) { return dst; }
            }
            string s = Path.GetFileNameWithoutExtension(src);
            Console.Write(":"+name+": "+s);
            var tm = new System.Diagnostics.Stopwatch();
            tm.Start();
            XmlDocument doc = new XmlDocument();
            if (((ext == ".xedf") ? Edif2Xmldoc(doc, src) :
                 (ext == ".xdata") ? Csv2Xmldoc(doc, src) : 
                 false)) {
                doc.Save(dst);
                tm.Stop();
                Console.WriteLine(" : "+tm.ElapsedMilliseconds+"ms");
                return dst;
            }
            Console.WriteLine("\nnot find: " + src);
            return "";
        }

        // xslt transformation
        public void Xslt(string src, string xsl, string dst, Dictionary<string, string> col)
        {
            Console.Write(":xsl: "+Path.GetFileNameWithoutExtension(dst));
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
                    if (v.EndsWith(".txt") || v.EndsWith(".csv")) Csv2Xmldoc(doc, v);
                    else doc.Load(v);
                    al.AddParam(k.Substring(1), "", doc);
                    continue;
                }
                al.AddParam(k, "", v);
            }
            ws.ConformanceLevel = ConformanceLevel.Fragment;
            ws.Indent = true;
            ws.IndentChars = "  ";
            XmlWriter wrt = XmlWriter.Create(dst, ws);
            trans.Transform(src, al, wrt);
            wrt.Close();
            tm.Stop();
            Console.WriteLine(" : "+tm.ElapsedMilliseconds+"ms");
        }

        public void Format(string src, string dst)
        {
            XmlDocument doc = new XmlDocument();
            doc.Load(src);
            doc.Save(dst);
        }

        public void Execute(string src, Dictionary<string, string> col)
        {
            string cur_dir = Directory.GetCurrentDirectory();
            string xsl_dir = Path.Combine(cur_dir, "xsl");

            src = Path.GetFullPath(src);
            string src_dir = Path.GetDirectoryName(src);
            string name = Path.GetFileNameWithoutExtension(src);
            string out_dir = Path.Combine(src_dir, name);
            if (!Directory.Exists(out_dir))
                Directory.CreateDirectory(out_dir);

            foreach (string k in Directory.EnumerateFiles(xsl_dir, "edif_*.xsl"))
            {
                string xsl = Path.Combine(xsl_dir, k);
                string dst = GetDestName(src, xsl);
                Xslt(src, xsl, Path.Combine(out_dir, dst), col);
            }

            string[] sub = new string[]{"page"};
            foreach (string grp in sub){
                string lst = Path.Combine(out_dir, "edif_"+grp+".lst");
                if (!File.Exists(lst)) return;
                foreach (string id in File.ReadAllLines(lst)) {
                    if (col.ContainsKey(grp)) col.Remove(grp);
                    col.Add(grp, id);
                    foreach (string k in Directory.EnumerateFiles(xsl_dir, grp+"_*.xsl"))
                    {
                        string xsl = Path.Combine(xsl_dir, k);
                        string dst = GetDestName(src, xsl).Replace(grp + "_", id + "_");
                        Xslt(src, xsl, Path.Combine(out_dir, dst), col);
                    }
                }
            }
        }
    }
}
