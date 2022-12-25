
using System;
using System.Collections.Generic;

namespace Document.Pdf
{
//     public class Xref
//     {
//         long _grp;
//         long _pos;
//         long _len;
//         PdfObj obj;

//         //xref
//         int _grp;
//         int _id;
//         int _rev;
//         int _type;
//         int _eol;

//         // string typ;
//         PdfValue _val;
//         byte[] _stm;

//         public PdfObj(PdfDoc doc, byte[] data)
//         {
//             _doc = doc;
//             //_pos = 0;
//             //_len = data.Length;
//             _bin = data;
//             _grp = 0;
//             _id = 0;
//             _rev = 0;
//             _type = 0;
//             _eol = 0;
//             _stm = data;
//             _val = null;
//         }
//         public PdfObj(PdfDoc doc, int id, int rev, int type, int eol)
//         {
//             _doc = doc;
//             //_pos = pos;
//             //_len = 0;
//             _bin = null;
//             _grp = 0;
//             _id = id;
//             _rev = rev;
//             _type = type;
//             _eol = eol;
//             _stm = null;
//             _val = null;
//         }

//         public int Group {
//             get { return _grp; }
//         }
//         public void SetID(int id, int rev) {
//             _id = id;
//             _rev = rev;
//         }
//         public int ID {
//             get { return _id; }
//         }
//         public bool FreeObj {
//             get { return (_type == 0); }
//         }
//         public int Type {
//             get { return _type; }
//         }
//         public int EOL {
//             get { return _eol; }
//         }
//         public int Revision {
//             get { return _rev; }
//         }
//         public PdfDoc Document {
//             get { return _doc; }
//         }
// //        public long Position {
// //            set { _pos = value; }
// //            get { return _pos; }
// //        }
// //        public long Length {
// //            set { _len = value; }
// //            get { return _len; }
// //        }
//         public byte[] Bytes {
//             // set { _bin = value; _len = _bin.Length; }
//             set { _bin = value; }
//             get { return _bin; }
//         }
//         public byte[] Stream {
//             set { _stm = value; }
//             get { return _stm; }
//         }
//         public PdfValue Value {
//             set { _val = value; }
//             get { return _val; }
//         }
//         public DictValue Dict {
//             get { return _val.Dict; }
//         }
//         public ArrayValue Array {
//             get { return _val.Array; }
//         }
//         public RefValue Ref {
//             get { return _val.Ref; }
//         }
//         public void print_value() { Value.print_value(); }
//     }

//     }
    // public class XrefTable
    // {
    //     long offset;
    //     long group;
        
    // }
    // public class XrefBlock
    // {
    //     long offset;
    //     long group;
        
    // }

}


// using System.IO;
// using System.Text;
// using System.IO.MemoryMappedFiles;
// using System.Runtime.InteropServices;

            // using (var mmf = MemoryMappedFile.CreateFromFile(filePath, FileMode.Open))
            // using (var vwa = mmf.CreateViewAccessor())
            // using (var vws = mmf.CreateViewStream())
            // using (var br = new BinaryReader(vws))

        /////////////////////////////////////////////////////////////////////
        // public bool GetXrefDirect(FileStream fs)
        // {
        //     obj_idx = 0;
        //     obj_lst.Clear();
        //     obj_col.Clear();
        //     long old_pos = fs.Position;
        //     int cnt;
        //     string s;
        //     int seq = 0;
        //     byte[] line;
        //     while ((line = GetLine(fs)) != null) {
        //         switch (seq) {
        //             case 0: {
        //                 if (GetSignature(line)) seq = 1;
        //                 break;
        //             }
        //             case 1: {
        //                 if (line[0] == 0x25) continue;
        //                 if (line.Length < 7 ||
        //                     line[line.Length-3] != 0x6F ||
        //                     line[line.Length-2] != 0x62 ||
        //                     line[line.Length-1] != 0x6A) continue;
        //                 s = Encoding.ASCII.GetString(line);
        //                 string[] ss = s.Split(' ');
        //                 if (ss.Length != 3) continue;
        //                 if (ss[2] != "obj") continue;
        //                 int idx = Int32.Parse(ss[0]);
        //                 int rev = Int32.Parse(ss[1]);
        //                 cnt = obj_lst.Count;
        //                 if (cnt > 0) {
        //                     int i = obj_lst[cnt-1];
        //                     long len = readPos - obj_col[i].Position;
        //                     obj_col[i].Length = len;
        //                 }
        //                 obj_lst.Add(idx);
        //                 PdfObj obj = new PdfObj(this, idx, rev, readPos);
        //                 obj_col.Add(idx, obj);
        //                 break;
        //             }
        //             default:{
        //                 break;
        //             }
        //         }
        //     }
        //     fs.Position = old_pos;
        //     cnt = obj_lst.Count;
        //     if (cnt > 0) {
        //         int i = obj_lst[cnt-1];
        //         long len = readPos - obj_col[i].Position;
        //         obj_col[i].Length = len;
        //     }
        //     return true;
        // }
