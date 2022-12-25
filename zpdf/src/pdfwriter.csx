using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.IO.Compression;

namespace Document.Pdf
{
    public class PdfWriter
    {
        public enum ObjType{
            UNKNOWN,
            INTEGER,
            FLOAT,
            NANE,
            STRING,
            DICT,
            LIST,
            NULL,
            ERROR
        };

        public PdfWriter(PdfDoc doc, int offset)
        {
            this.doc = doc;
            this.offset = offset;
            this.data = null;

            string s = doc.GetString(offset);
            string[] ss = s.Split(' ');
            obj_type = ObjType.ERROR;
            if (ss[2] == "obj"){
                obj_type = ObjType.UNKNOWN;
                obj_id = Int32.Parse(ss[0]);
                obj_rev = Int32.Parse(ss[1]);
                s = doc.GetString(offset, 1);
                ss = s.Split(' ');
                foreach (string a in ss){
                    Console.WriteLine(">"+a);
                }
            }
        }

        public void debug_print()
        {
        }

        ///////////////////////////////////////////////////////////////////////
        public static void test()
        {
            using (var ms = new MemoryStream(src, idx, size))
            using (var ds = new DeflateStream(ms, CompressionMode.Decompress))
            using (FileStream dst = new FileStream("test.out", FileMode.Create))


        }
    }
}
