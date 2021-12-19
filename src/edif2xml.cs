using System;
using System.IO;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml;
using System.Drawing;
using System.Windows.Forms;

namespace Edif2Xml
{
    public class Program
    {
        static string msg = "error : ";

        static List<string> s_tok(string src, string enc = "Shift_JIS")
        {
            List<string> lst = new List<string>();
            string s = "";
            bool skip = false;
            int seq = 0;

            using (StreamReader sr = new StreamReader(src, Encoding.GetEncoding(enc))) {
                string line;
                while ((line = sr.ReadLine()) != null) {
                    L1: foreach (char c in line) {
                        if (seq == 1) {
                            s += c;
                            if (skip) { skip = false; }
                            else if (c == '\\') { skip = true; }
                            else if (c == '\"') { lst.Add(s); s = ""; seq = 0; }
                            continue;
                        }
                        switch (c) {
                            case '#': case ';': if (s.Length > 0) { lst.Add(s); } s = ""; goto L1;
                            case '(': case ')': if (s.Length > 0) { lst.Add(s); } s = ""; s += c; lst.Add(s); s = ""; break;
                            case ' ': case '\t': if (s.Length > 0) { lst.Add(s); } s = ""; break;
                            case '\"': if (s.Length > 0) { lst.Add(s); } s = ""; s += c; seq = 1; break;
                            default: s += c; break;
                        }
                    }
                    if (seq == 1) { s += '\n'; }
                }
                if (s.Length > 0) { lst.Add(s); s = ""; }
            }
            return lst;
        }

        static List<string> sn = new List<string>() {"name", "rename"};
        static List<string> nm = new List<string>() {
            "edif", "design", "external", "library", "cell", "view", "page", 
            "instance", "portInstance", "port", "portBundle", "portListAlias", 
            "portImplementation", 
            "viewRef", "portRef", "instanceRef", "cellRef", "libraryRef", 
            "figureGroup", "figureGroupOverride", "figure", "offpageConnector",
            "net", "netBundle", "property", "parameter", "display", "keywordDisplay"
        };

        static System.Xml.XmlDocument s_prs(List<string> lst)
        {
            System.Xml.XmlDocument doc = new System.Xml.XmlDocument();
            doc.AppendChild(doc.CreateXmlDeclaration("1.0", null, null));
            System.Xml.XmlNode node = doc;
            int seq = 0;
            int lvl = 0;

            foreach (string v in lst) {
                if (v == "(") { if (lvl > 0) { lvl++; break; } seq = 1; continue; }
                if (v == ")") { if (lvl > 0) { lvl--; break; } node = node.ParentNode; seq = 4; continue; }
                string s = v;
                // Regex re = new Regex("%(\\d+)%");
                // foreach(Match ma in re.Matches(v)){
                //     //s = [regex]::replace(s, "%(\d+)%", { [char]([int]($args.groups[1].value)) })
                // }
                switch (seq) {
                    case 1: {
                        node = node.AppendChild(doc.CreateNode("element", s.ToLower(), null));
                        if (nm.Contains(s)) { seq = 2; } else if (sn.Contains(s)) { seq = 3; } else { seq = 4; }
                        break;
                    }
                    case 2: { ((System.Xml.XmlElement)node).SetAttribute("name", s); seq = 5; break; }
                    case 3: { ((System.Xml.XmlElement)node.ParentNode).SetAttribute("name", s); seq = 4; break; }
                    case 4: { node.AppendChild(doc.CreateTextNode(s)); seq = 5; break; }
                    case 5: {
                        node.AppendChild(doc.CreateWhitespace(" "));
                        node.AppendChild(doc.CreateTextNode(s));
                        break;
                    }
                    default: break;
                }
            }
            return doc;
        }

        public static bool edif2xml(string src, string encoding = "Shift_JIS")
        {
            if (! File.Exists(src)){ msg = "not find source file: "; return false; }
            string dst = src + ".xml";
            if (File.Exists(dst)){ msg = "output file alived: "; return false; }
            List<string> lst = s_tok(src, encoding);
            System.Xml.XmlDocument doc = s_prs(lst);
            doc.Save(dst);
            return true;
        }

        public static void Main(string[] args)
        {
            try
            {
                foreach (string arg in args)
                {
                    if (! edif2xml(arg)) {
                        MessageBox.Show(msg + arg);
                        continue;
                    }
                }
            }
            catch
            {
                MessageBox.Show("error.");
            }
        }
    }
}
