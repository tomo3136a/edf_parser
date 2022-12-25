using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace Document.Pdf
{
    public class PdfValue
    {
        //value type
        public const string a_value = "a";      //array object
        public const string d_value = "d";      //dictionary object
        public const string i_value = "i";      //int object
        public const string f_value = "f";      //float object
        public const string n_value = "n";      //name object
        public const string l_value = "l";      //literal-string object
        public const string h_value = "h";      //hexical-string object
        public const string o_value = "o";      //operation
        public const string r_value = "r";      //refarence
        public const string s_value = "s";      //stream data

        protected string type;
        protected string value;
        protected byte[] ba;

        //constructor
        protected PdfValue(){}
        protected PdfValue(string t){ type = t; value = type; }
        protected PdfValue(string t, string v){ type = t; value = v; }
        protected PdfValue(string t, byte[] v){ type = t; ba = v; }
        //creator
        public static ArrayValue CreateArray(){ return ArrayValue.Create(); }
        public static DictValue CreateDict(){ return DictValue.Create(); }
        public static PdfValue CreateRef(PdfDoc doc, int idx, int rev){
            return RefValue.Create(doc, idx, rev);
        }
        public static PdfValue CreateInt(string s){ return new PdfValue(i_value, s); }
        public static PdfValue CreateFloat(string s){ return new PdfValue(f_value, s); }
        public static PdfValue CreateName(string s){ return new PdfValue(n_value, s); }
        public static PdfValue CreateString(string s){ return new PdfValue(l_value, s); }
        public static PdfValue CreateHex(string s){ return new PdfValue(h_value, s); }
        public static PdfValue CreateOpe(string s){ return new PdfValue(o_value, s); }
        public static PdfValue CreateStream(PdfDoc doc, long pos, long len){
            return StmValue.Create(doc, pos, len);
        }
        public static PdfValue CreateStream(DictValue dict, byte[] buf, int pos, int len){
            return StmValue.Create(dict, buf, pos, len);
        }
        public static PdfValue Create(string type, byte[] ba, int pos, int len){
            switch (type) {
                case a_value: return CreateArray();
                case d_value: return CreateDict();
            }
            if (ba == null){ return new PdfValue(type, type); }
            byte[] v = new byte[len];
            System.Array.Copy(ba, pos, v, 0, len);
            return new PdfValue(type, v);
        }
        public static PdfValue Create(string type, string val){
            return new PdfValue(type, val);
        }
        //accessor
        public string Type { get{ return type; } }
        public string Value { get{ return ToString(); } }
        public override string ToString() {
            return (value == null) ? Encoding.ASCII.GetString(ba) : value;
        }
        public ArrayValue Array { get { return (ArrayValue)this; } }
        public DictValue Dict { get { return (DictValue)this; } }
        public RefValue Ref { get { return (RefValue)this; } }

        public int IntValue { get{ return Int32.Parse(Value); } }
        public long LongValue { get{ return Int64.Parse(Value); } }
        public float FloatValue { get{ return Single.Parse(Value); } }
        public byte[] BinaryValue { get{ return ba; } }

        public void print_value(string spc="")
        {
            switch (Type) {
                case a_value: {
                    Console.WriteLine("[");
                    var arr = Array;
                    string s = spc + "  ";
                    foreach (var v in arr.Values) {
                        Console.Write(s);
                        v.print_value(s);
                    }
                    Console.WriteLine(spc + "]");
                    break;
                }
                case d_value: {
                    Console.WriteLine("{");
                    var dict = Dict;
                    string s = spc + "  ";
                    foreach (var k in dict.Keys) {
                        Console.Write(s + k + "=");
                        dict[k].print_value(s);
                    }
                    Console.WriteLine(spc + "}");
                    break;
                }
                default: Console.WriteLine(Type + ":" + Value); break;
            }
        }
    }

    /////////////////////////////////////////////////////////////////////////
    public class ArrayValue : PdfValue
    {
        List<PdfValue> col = new List<PdfValue>();
        ArrayValue(){ type = a_value; value = type; }
        public static ArrayValue Create(){ return new ArrayValue(); }
        public bool Add(PdfValue val) { col.Add(val); return true; }
        // public List<PdfValue> Collection { get { return col; } }
        public int Count { get { return col.Count; } }
        public List<PdfValue> Values { get { return col; } }
        public PdfValue this[int idx] { get{ return col[idx]; } }
        public void Reverse() { col.Reverse(); }
        public override string ToString() {
            string s = "[";
            foreach(var v in col){ s += v + " "; }
            return s.Trim() + "]";
        }
    }

    /////////////////////////////////////////////////////////////////////////
    public class DictValue : PdfValue
    {
        Dictionary<string, PdfValue> col = new Dictionary<string, PdfValue>() { };
        DictValue(){ type = d_value; value = type; }
        public static DictValue Create(){ return new DictValue(); }
        public bool Add(string key, PdfValue val) { col.Add(key, val); return true; }
        public Dictionary<string, PdfValue> Collection { get { return col; } }
        public bool ContainsKey(string key) { return col.ContainsKey(key); }
        public Dictionary<string, PdfValue>.KeyCollection Keys { get { return col.Keys; } }
        public PdfValue this[string key] { get{ return col[key]; } }
        public override string ToString() {
            string s = "<<";
            foreach(var p in col){ s += p.Key + " " + p.Value; }
            return s + ">>";
        }
    }

    /////////////////////////////////////////////////////////////////////////
    public class StmValue : PdfValue
    {
        Dictionary<string, PdfValue> col = new Dictionary<string, PdfValue>() { };
        PdfDoc doc;
        long pos;
        long len;
        byte[] stm;
        StmValue(){ type = s_value; value = type; }
        public static StmValue Create(PdfDoc doc, long pos, long len){
            var val = new StmValue();
            val.doc = doc; val.pos = pos; val.len = len;
            val.value = ""+pos+"."+len;
            return val;
        }
        public static StmValue Create(DictValue dict, byte[] buf, int pos, int len){
            var val = new StmValue();
            var ba = new byte[len];
            System.Array.Copy(buf, pos, ba, 0, len);
            val.stm = ba;
            return val;
        }
        public bool Add(string key, PdfValue val) { col.Add(key, val); return true; }
        public Dictionary<string, PdfValue>.KeyCollection Keys { get { return col.Keys; } }
        public PdfValue this[string key] { get{ return col[key]; } }
        public PdfDoc Document { get{ return doc; } }
        public long Position { get{ return pos; } }
        public long Length { get{ return len; } }
        public override string ToString() {
            string s = "<<";
            foreach(var p in col){ s += p.Key + " " + p.Value; }
            s += ">>";
            s += "stream";
            return s;
        }
    }

    /////////////////////////////////////////////////////////////////////////
    public class RefValue : PdfValue
    {
        PdfDoc doc;
        int id;
        int rev;
        RefValue(){ type = r_value; value = type; }
        public static RefValue Create(PdfDoc doc, int id, int rev) {
            var val = new RefValue();
            val.doc = doc; val.id = id; val.rev = rev;
            val.value = ""+id+"."+rev;
            return val;
        }
        public PdfDoc Document { get{ return doc; } }
        public int Index { get{ return (id<<16)+rev; } }
        public int ID { get{ return id; } }
        public int Revision { get{ return rev; } }
        public PdfObj GetObj(BinaryReader br) { return doc.GetObj(br, id, rev); }
        // public override string ToString() { return "" + id + " "+ rev + " R"; }
        public override string ToString() { 
            return String.Format("{0:00000}.{1:00000}", id , rev);
        }

    }

    /////////////////////////////////////////////////////////////////////////

}
