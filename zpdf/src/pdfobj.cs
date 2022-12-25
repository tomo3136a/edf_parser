using System;
using System.Collections.Generic;
using System.IO;
using System.Text;
using System.IO.Compression;

namespace Document.Pdf
{
    public class PdfObj
    {
        //location
        PdfDoc _doc;
        long _grp;
        long _pos;
        long _len;

        //xref
        int _id;
        int _rev;
        int _type;
        int _eol;

        //data
        byte[] _bin;
        byte[] _stm;
        PdfValue _val;

        public PdfObj(PdfDoc doc, byte[] data)
        {
            _doc = doc;
            _grp = 0;
            _pos = 0;
            _len = data.Length;
            _id = 0;
            _rev = 0;
            _type = 0;
            _eol = 0;
            _bin = data;
            _stm = data;
            _val = null;
        }
        public PdfObj(PdfDoc doc, int id, int rev, long grp, long pos, int type, int eol)
        {
            _doc = doc;
            _grp = grp;
            _pos = pos;
            _len = 0;
            _id = id;
            _rev = rev;
            _type = type;
            _eol = eol;
            _bin = null;
            _stm = null;
            _val = null;
        }

        public PdfDoc Document { get { return _doc; } }
        public long Group { get { return _grp; } }
        public long Position { set { _pos = value; } get { return _pos; } }
        public long Length { set { _len = value; } get { return _len; } }

        public void SetID(int id, int rev) { _id = id; _rev = rev; }
        public int ID { get { return _id; } }
        public int Revision { get { return _rev; } }
        // public bool FreeObj {
        //     get { return (_type == 0); }
        // }
        public int Type { get { return _type; } }
        public int EOL { get { return _eol; } }

        public byte[] Bytes {
            set { _bin = value; _len = _bin.Length; }
            get { return _bin; }
        }
        public byte[] Stream { set { _stm = value; } get { return _stm; } }
        public PdfValue Value { set { _val = value; } get { return _val; } }
        public DictValue Dict { get { return _val.Dict; } }
        public ArrayValue Array { get { return _val.Array; } }
        public RefValue Ref { get { return _val.Ref; } }

        public void print_value() {
            Console.Write("obj: "+ID+"."+Revision+" ");
            Value.print_value();
        }
    }
}
