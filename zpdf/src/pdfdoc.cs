using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace Document.Pdf
{
    using PC = Constant;
    using PN = Name;

    public class PdfDoc
    {
        //document
        string filePath;
        string fileType;
        int mjr_ver = 0;
        int min_ver = 0;
        byte[] sig;

        //position
        //BinaryReader br = null;
        long firstPos = 0;
        long xrefPos = 0;
        long startPos = 0;

        //constructor
        public PdfDoc(string path)
        {
            filePath = path;
            fileType = null;
        }

        //accessor
        public string FilePath { get{ return filePath; } }
        public string FileType { get{ return fileType+"-"+mjr_ver+"."+min_ver; } }

        /////////////////////////////////////////////////////////////////////
        //Read Buffer
        const int BUFSIZE_BITS = 12;
        const int BUFSIZE = 1<<BUFSIZE_BITS;

        /////////////////////////////////////////////////////////////////////
        //xref table
        public Dictionary<int, PdfObj> xrefMap = new Dictionary<int, PdfObj>();
        public List<int> xrefList = new List<int>();

        public void ClearXrefTable() {
            xrefMap.Clear();
            xrefList.Clear();
        }

        public bool AddXref(int id, int rev, long grp, long pos, int type, int eol) {
            int i = (id << 16) + rev;
            xrefMap.Add(i, new PdfObj(this, id, rev, grp, pos, type, eol));
            xrefList.Add(i);
            return true;
        }
        public PdfObj GetXrefObj(int id, int rev) {
            int i = (id << 16) + rev;
            return xrefList.Contains(i) ? xrefMap[i] : null;
        }
        // public List<int> UpdateXrefList() {
        //     var lst = new List<int>(xrefList);
        //     lst.Sort((a,b) => (int)(xrefMap[b].Position - xrefMap[a].Position));
        //     long pos = xrefPos;
        //     for (int i = 0; i < lst.Count; i ++) {
        //         long p = pos;
        //         int idx = lst[i];
        //         pos = xrefMap[idx].Position;
        //         if (xrefMap[idx].Type < 2) xrefMap[idx].Length = p - pos;
        //     }
        //     return lst;
        // }
        public string ToXrefIndex(int idx) {
            return String.Format("{0:00000}.{1:00000}", (idx >> 16), (idx & 65535));
        }
        public bool PrintXref(int id, int rev, long grp, long pos, long len, int type, int eol) {
            int i = (id << 16) + rev;
            var s_type = (type == 1) ? PC.N : (type == 2) ? "c" : PC.F;
            var s_eol = (eol == 1) ? "LF" : (eol == 2) ? "CR" : (eol == 3) ? "CRLF" : "LF";
            var fmt = "{0:0000000000}({1:X8}) {2:00000}.{3:00000} {4} {5}";
            var s = String.Format(fmt, pos, pos, id, rev, s_type, s_eol);
            Console.WriteLine("xref: "+s+" grp="+grp+" len="+len);
            return true;
        }
        public bool PrintXref(PdfObj obj)
        {
            return PrintXref(obj.ID, obj.Revision, obj.Group, obj.Position, obj.Length, obj.Type, obj.EOL);
        }
        public bool PrintXref(int idx)
        {
            return PrintXref(xrefMap[idx]);
        }
        public bool PrintXref()
        {
            Console.WriteLine("xref: cnt="+xrefList.Count);
            foreach (var idx in xrefList) PrintXref(idx);
            return true;
        }

        /////////////////////////////////////////////////////////////////////
        //trailer
        // PdfVal trailer;
        int t_size;
        int t_root;
        int t_info;

        public bool PrintTrailer()
        {
            Console.WriteLine("size="+t_size+" root=#"+ToXrefIndex(t_root)+" info=#"+ToXrefIndex(t_info));
            Console.Write("ROOT "); PrintXref(t_root);
            Console.Write("INFO "); PrintXref(t_info);
            return true;
        }

        /////////////////////////////////////////////////////////////////////
        //object
        int o_idx;
        int o_rev;
        long o_pos;
        PdfObj o_obj;
        byte[] o_stm;

        public void init_obj()
        {
            o_idx = 0;
            o_rev = 0;
            o_pos = 0;
            o_obj = null;
            o_stm = null;
        }
 
        /////////////////////////////////////////////////////////////////////
        //stream
        long s_pos;
        int s_length;

        /////////////////////////////////////////////////////////////////////
        //value
        const string array_open = "[";
        const string array_close = "]";
        const string dict_open = "<";
        const string dict_close = ">";

        PdfValue value_null = PdfValue.CreateOpe(PC.NULL);
        PdfValue value_true = PdfValue.CreateOpe(PC.TRUE);
        PdfValue value_false = PdfValue.CreateOpe(PC.FALSE);

        /////////////////////////////////////////////////////////////////////
        //object
        bool ParseXref(PdfValue pv)
        {
            string s = pv.Value;
            switch (p_sub ++) {
                case 0: p_xrefFirst = Int32.Parse(s); p_xrefIndex = 0; break;
                case 1: p_xrefCount = p_xrefIndex + Int32.Parse(s); break;
                default: p_stk.Push(pv); break;
            }
            return true;
        }

        /////////////////////////////////////////////////////////////////////
        //parser
        string p_mode;
        int p_sub = 0;
        long p_pos = 0;
        Stack<PdfValue> p_stk = new Stack<PdfValue>();
        PdfValue p_base = null;
        int p_xrefFirst = 0;
        int p_xrefIndex = 0;
        int p_xrefCount = 0;

        public void init_parse()
        {
            p_mode = null;
            p_sub = 0;
            p_pos = 0;
            p_stk.Clear();
            p_base = null;
            p_xrefFirst = 0;
            p_xrefIndex = 0;
            p_xrefCount = 0;
        }

        public PdfValue parse_ope(byte[] buf, int ps, int pe)
        {
            var pv = PdfValue.Create(PdfValue.o_value, buf, ps, pe - ps);
            switch (pv.Value) {
                case PC.NULL: p_stk.Push(value_null); break;
                case PC.TRUE: p_stk.Push(value_true); break;
                case PC.FALSE: p_stk.Push(value_false); break;
                case PC.R: {
                    int rev = p_stk.Pop().IntValue;
                    int id = p_stk.Pop().IntValue;
                    p_stk.Push(PdfValue.CreateRef(this, id, rev));
                    break;
                }
                case PC.OBJ: {
                    init_obj();
                    o_rev = p_stk.Pop().IntValue;
                    o_idx = p_stk.Pop().IntValue;
                    o_pos = p_pos;
                    o_obj = new PdfObj(this, o_idx, o_rev, 0, o_pos, 0, 0);
                    o_stm = null;
                    p_mode = pv.Value;
                    break;
                }
                case PC.ENDOBJ: o_obj.Value = p_stk.Pop(); p_mode = pv.Value; break;
                case PC.STREAM: {
                    var val = p_stk.Peek();
                    s_length = val.Dict[PN.LENGTH].IntValue;
                    o_obj.Value = val;
                    p_mode = pv.Value;
                    break;
                }
                case PC.ENDSTREAM: { p_mode = pv.Value; break; }
                case PC.STARTXREF: p_mode = pv.Value; break;
                case PC.XREF: p_mode = pv.Value; p_sub = 0; break;
                case PC.F: case PC.N: p_stk.Push(pv); p_mode = pv.Value; break;
                case PC.TRAILER: p_mode = pv.Value; break;
                default: p_stk.Push(pv); break;
            }
            return pv;
        }

        public PdfValue parse_xrefeol(byte[] buf, int ps, int pe) {
                int id = p_xrefFirst + p_xrefIndex;
                int type = (p_stk.Pop().Value == PC.N) ? 1 : 0;
                int rev = p_stk.Pop().IntValue;
                long pos = p_stk.Pop().LongValue;
                int eol = (PC.SP == buf[ps]) ? ((PC.LF == buf[pe]) ? 0 : 1) : 2;
                AddXref(id, rev, p_xrefFirst, pos, type, eol);
                if ((++ p_xrefIndex) == p_xrefCount) { p_sub = 0; }
            return null;
        }
        public PdfValue parse_stream(byte[] buf, int ps, int pe) {
            o_stm = new byte[pe-ps];
            Array.Copy(buf, ps, o_stm, 0, pe-ps);
            return null;
        }
        public PdfValue parse_array_open() {
            p_stk.Push(p_base);
            p_base = PdfValue.CreateArray();
            p_stk.Push(p_base);
            return p_base;
        }
        public PdfValue parse_array_close() {
            var col = p_base.Array;
            PdfValue pv;
            while ((pv = p_stk.Pop()) != p_base) col.Add(pv);
            col.Reverse();
            pv = p_base;
            p_base = p_stk.Pop();
            p_stk.Push(col);
            return pv;
        }
        public PdfValue parse_dict_open() {
            p_stk.Push(p_base);
            p_base = PdfValue.CreateDict();
            p_stk.Push(p_base);
            return p_base;
        }
        public PdfValue parse_dict_close() {
            var col = p_base.Dict;
            PdfValue pv;
            while ((pv = p_stk.Pop()) != p_base) col.Add(p_stk.Pop().Value, pv);
            pv = p_base;
            p_base = p_stk.Pop();
            p_stk.Push(col);
            return pv;
        }
        public PdfValue parse_value(string type, byte[] buf, int ps, int pe)
        {
            PdfValue pv = PdfValue.Create(type, buf, ps, pe - ps);
            switch (p_mode) {
                case PC.XREF: ParseXref(pv); return pv;
                case PC.STARTXREF: xrefPos = pv.IntValue; p_mode = null; return pv;
            }
            p_stk.Push(pv);
            return pv;
        }

        /////////////////////////////////////////////////////////////////////
        //token
        byte[] t_buf = new byte[2*BUFSIZE];
        int t_seq = 0;
        int t_pos = 0;
        long t_base = 0;

        public bool init_token()
        {
            t_seq = 0;
            t_pos = 0;
            t_base = 0;
            return true;
        }

        public int token(byte[] buf, int ps, int pe)
        {
            int seq = t_seq;
            int pos = t_pos;
            int i = ps;
            while (i < pe) {
                byte b = buf[i++];
                switch (seq) {
                    case 0: //space
                    if (b <= 0x20) { pos = i; break; }
                    if (b >= 0x30 && b <= 0x39) { seq = 1; break; } // 0-9
                    if (b == 0x2b || b == 0x2d) { seq = 1; break; } // +-
                    if (b == 0x2e) { seq = 2; break; } // .
                    if (b == 0x2f) { seq = 3; break; } // /
                    if (b == 0x3c) { seq = 4; break; } // <
                    if (b == 0x3e) { seq = 6; break; } // >
                    if (b == 0x5b) { parse_array_open(); pos = i; break; }
                    if (b == 0x5d) { parse_array_close(); pos = i; break; }
                    if (b <= 0x25) { seq = 7; break; } // %
                    if (b <= 0x28) { seq = 8; break; } // (
                    if (b >= 0x41 && b <= 0x5a) { seq = 10; break; } // A-Z
                    if (b >= 0x61 && b <= 0x7a) { seq = 10; break; } // a-z
                    token_error("token-0", buf, pos, i); pos = i; break;

                    case 1: //number
                    if (b >= 0x30 && b <= 0x39) break; // 0-9
                    if (b == 0x2e) { seq = 2; break; } // .
                    parse_value(PdfValue.i_value, buf, pos, --i);
                    pos = i; seq = 0; break;

                    case 2: // number(float)
                    if (b >= 0x30 && b <= 0x39) break; // 0-9
                    parse_value(PdfValue.f_value, buf, pos, --i);
                    pos = i; seq = 0; break;

                    case 3: // name
                    if (b >= 0x30 && b <= 0x39) break; // 0-9
                    if (b >= 0x41 && b <= 0x5a) break; // A-Z
                    if (b >= 0x61 && b <= 0x7a) break; // a-z
                    parse_value(PdfValue.n_value, buf, pos, --i);
                    pos = i; seq = 0; break;

                    case 4: // string+map
                    if (b != 0x3c) { i --; seq = 5; break; } // <
                    parse_dict_open();
                    pos = i; seq = 0; break;

                    case 5: // hex-string
                    if (b >= 0x30 && b <= 0x39) break; // 0-9
                    if (b >= 0x41 && b <= 0x5a) break; // A-Z
                    if (b >= 0x61 && b <= 0x7a) break; // a-z
                    if (b == 0x3e) parse_value(PdfValue.h_value, buf, pos+1, i-1);
                    else token_error("token-5", buf, pos+1, i-1);
                    pos = i; seq = 0; break;

                    case 6: // map-end
                    if (b == 0x3e) parse_dict_close();
                    else token_error("token-6", buf, pos+1, i-1);
                    pos = i; seq = 0; break;

                    case 7: // comment
                    if (b != 10 && b != 13) break;
                    pos = i; seq = 0; break;

                    case 8: // literal-string
                    if (b == 0x5c) { seq ++; break; }
                    if (b != 0x29) break;
                    parse_value(PdfValue.l_value, buf, pos+1, i-1);
                    pos = i; seq = 0; break;

                    case 9: // literal-string-escape
                    seq --; break;

                    case 10: // ope
                    if (b >= 0x41 && b <= 0x5a) break; // A-Z
                    if (b >= 0x61 && b <= 0x7a) break; // a-z
                    parse_ope(buf, pos, --i);
                    if (p_mode == PC.ENDOBJ) { t_seq = 0; t_pos = i; return 0; }
                    if (p_mode == PC.STARTXREF) { t_seq = 0; t_pos = i; return 0; }
                    if (p_mode == PC.STREAM) { pos = i; seq = 11; break; }
                    if (p_mode == PC.F || p_mode == PC.N) { pos = i; seq = 12; break; }
                    pos = i; seq = 0; break;

                    case 11: // stream
                    if (b == 10 || b == 13)  { pos = i; break; }
                    s_pos = pos + t_base;
                    i = pos + s_length;
                    parse_stream(buf, pos, i);
                    pos = i-1; seq = 0; break;

                    case 12: // xref-eol
                    parse_xrefeol(buf, pos, i);
                    pos = i; seq = 0; break;

                    default: pos = i; seq = 0; break;
                }
            }
            t_seq = seq;
            t_pos = pos;
            return i;
        }

        public void token_error(string msg, byte[] buf, int ps, int pe)
        {
            string s = Encoding.ASCII.GetString(buf, ps, pe - ps);
            Console.Write("error: "+msg+" ("+s+")");
            Console.WriteLine(" mode="+p_mode+" sub="+p_sub+" pos="+p_pos);
        }

        /////////////////////////////////////////////////////////////////////
        public bool InitParser()
        {
            init_token();
            init_parse();
            init_obj();
            return true;
        }

        public int line_eol; // 0:other 1: LF 2: SPCR 3: SPLF
        public byte[] ReadLine(BinaryReader br)
        {
            long pos = br.BaseStream.Position;
            long len = br.BaseStream.Length;
            byte b;
            line_eol = 0;
            while (true) {
                if (pos ++ >= len) return null;
                b = br.ReadByte();
                if (b > 32) break;
            }
            using (var ms = new MemoryStream())
            {
                ms.WriteByte(b);
                while (pos ++ < len) {
                    b = br.ReadByte();
                    if (b == 10 || b == 13) break;
                    line_eol = (b == 32) ? 2 : 0;
                    ms.WriteByte(b);
                }
                line_eol += (b == 10) ? 1 : 0;
                return ms.ToArray();
            }
        }

        public bool GetHeader(BinaryReader br)
        {
            byte[] ba = new byte[32];
            if (32 != br.Read(ba, 0, 32)) return false;
            if (ba[0] != 0x25) return false;
            string s = Encoding.ASCII.GetString(ba);
            if (s.StartsWith(PC.SIG_PDF)) 
                fileType = PC.PDF;
            else if (s.StartsWith(PC.SIG_FDF)) 
                fileType = PC.FDF;
            else return false;
            mjr_ver = Int32.Parse(s.Substring(5,1));
            min_ver = Int32.Parse(s.Substring(7,1));

            int pos = 0;
            int len = ba.Length;
            for (int i = 0; i < len; i ++) {
                byte b = ba[i];
                if (b == 10 || b == 13) pos = i + 1;
                else if (pos == i && b != 0x25) break;
            } 
            sig = new byte[pos];
            Array.Copy(ba, 0, sig, 0, pos);
            firstPos = pos;
            Console.Write("sig: ");
            Util.hexdump(sig);
            return true;
        }

        // public bool GetHeader(byte[] ba)
        // {
        //     if (ba[0] != 0x25) return false;
        //     string s = Encoding.ASCII.GetString(ba);
        //     if (s.StartsWith(PC.SIG_PDF)) 
        //         fileType = PC.PDF;
        //     else if (s.StartsWith(PC.SIG_FDF)) 
        //         fileType = PC.FDF;
        //     else return false;
        //     mjr_ver = Int32.Parse(s.Substring(5,1));
        //     min_ver = Int32.Parse(s.Substring(7,1));
        //     return true;
        // }

        public long GetStartXref(BinaryReader br)
        {
            if (xrefPos != 0) return xrefPos;
            br.BaseStream.Seek(-32, SeekOrigin.End);
            byte[] ba;
            while (true) {
                if ((ba = ReadLine(br)) == null) return 0;
                var s = Encoding.ASCII.GetString(ba);
                if (s == PC.STARTXREF) break;
            }
            startPos = br.BaseStream.Position;
            startPos -= PC.STARTXREF.Length + 1;
            if ((ba = ReadLine(br)) == null) return 0;
            xrefPos = Int64.Parse(Encoding.ASCII.GetString(ba));
            return xrefPos;
        }

        public PdfObj ReadObj(BinaryReader br, long offset)
        {
            InitParser();
            br.BaseStream.Seek(offset, SeekOrigin.Begin);
            p_pos = offset;
            t_base = offset;
            t_pos = BUFSIZE;
            int pos = 0;
            int len = 0;
            while (true) {
                len = br.Read(t_buf, BUFSIZE, BUFSIZE);
                if (len <= 0) return null;
                pos = token(t_buf, t_pos, BUFSIZE + len);
                if (pos == 0) break;
                while (pos >= 3*BUFSIZE) {
                    Array.Copy(t_buf, BUFSIZE, t_buf, 0, BUFSIZE);
                    t_base += BUFSIZE;
                    t_pos -= BUFSIZE;
                    pos -= BUFSIZE;
                    len = br.Read(t_buf, BUFSIZE, BUFSIZE);
                    if (len <= 0) return null;
                }
                Array.Copy(t_buf, BUFSIZE, t_buf, 0, BUFSIZE);
                t_base += BUFSIZE;
                t_pos -= BUFSIZE;
                pos -= BUFSIZE;
            }
            return o_obj;
        }

        public PdfObj GetStmObj(BinaryReader br, long pos, int rev)
        {
            var obj = GetObj(br, (int)pos, rev);
            obj.print_value();
            var dict = obj.Dict;
            if (null == o_stm) return obj;
            int s_filter = (dict[PN.FILTER].Value == PN.FLATEDECODE) ? 4 : 0;
            int s_columns = 0;
            int s_predictor = 0;
            byte[] ba = Util.GetStreamData(o_stm, 0, o_stm.Length, s_filter, s_predictor, s_columns);
            int cnt = dict[PN.N].IntValue;
            int len1 = dict[PN.FIRST].IntValue;
            int len2 = dict[PN.LENGTH].IntValue;
            byte[] ba1 = new byte[len1];
            Array.Copy(ba, 0, ba1, 0, len1);
            var s1 = Encoding.ASCII.GetString(ba1).Split(' ');
            int o_idx = Int32.Parse(s1[2*rev]);
            int o_pos = Int32.Parse(s1[2*rev+1]) + len1;
            int o_len = (cnt == rev+1) ? ba.Length : (Int32.Parse(s1[2*rev+3]) + len1);
            o_len = o_len - o_pos;
            byte[] ba2 = new byte[o_len];
            Array.Copy(ba, o_pos, ba2, 0, o_len);
            InitParser();
            token(ba2, t_pos, o_len);
            obj = new PdfObj(this, o_idx, rev, 0, o_pos, 0, 0);
            obj.Value = p_stk.Pop();
            return obj;
        }

        public PdfObj GetObj(BinaryReader br, int idx)
        {
            var obj = xrefMap[idx];
            //var obj = GetXrefObj(id, rev);
            if (null == obj) return null;
            int o_rev = obj.Revision;
            int o_type = obj.Type;
            long o_pos = obj.Position;
            long o_len = obj.Length;
            if (2 == o_type) return GetStmObj(br, o_pos, o_rev);
            if (0 == o_len) return ReadObj(br, o_pos);
            InitParser();
            br.BaseStream.Seek(o_pos, SeekOrigin.Begin);
            t_base = o_pos;
            int len = (int)o_len;
            byte[] buf = br.ReadBytes(len);
            token(buf, t_pos, len);
            if (null == o_obj) return null;
            return o_obj;
        }
        public PdfObj GetObj(BinaryReader br, int id, int rev)
        {
            return GetObj(br, (id<<16)+rev);
        }

        /////////////////////////////////////////////////////////////////////
        public bool LoadXrefObj(PdfObj obj)
        {
            var dict = obj.Dict;
            if (o_stm == null) return false;
            if (! dict.ContainsKey(PN.TYPE)) return false;
            if (dict[PN.TYPE].Value != PN.XREF) return false;
            int s_filter = (dict[PN.FILTER].Value == PN.FLATEDECODE) ? 4 : 0;
            var decode = dict[PN.DECODEPARMS].Dict;
            int s_columns = decode[PN.COLUMNS].IntValue;
            int s_predictor = decode[PN.PREDICTOR].IntValue;
            byte[] ba = Util.GetStreamData(o_stm, 0, o_stm.Length, s_filter, s_predictor, s_columns);
            int idx = 0;
            int cnt = dict[PN.SIZE].IntValue;
            if (dict.ContainsKey(PN.INDEX)) {
                idx = dict[PN.INDEX].Array[0].IntValue;
                cnt = dict[PN.INDEX].Array[1].IntValue;
            }
            p_xrefFirst = idx;
            int sz1 = dict[PN.W].Array[0].IntValue;
            int sz2 = dict[PN.W].Array[1].IntValue;
            int sz3 = dict[PN.W].Array[2].IntValue;
            for (int i = 0, j = 0, p = 0; i < cnt; i ++) {
                int type = 0; for (j = 0; j < sz1; j ++) type = 256*type + (int)ba[p++];
                long pos = 0; for (j = 0; j < sz2; j ++) pos = 256*pos + (long)ba[p++];
                int rev = 0; for (j = 0; j < sz3; j ++) rev = 256*rev + (int)ba[p++];
                AddXref(idx++, rev, p_xrefFirst, pos, type, 0);
            }
            return true;
        }

        public bool ReadXrefTable(BinaryReader br, long offset)
        {
            var obj = ReadObj(br, offset);
            if (null != obj && false == LoadXrefObj(obj)) return false;
            var val = (null == obj) ? p_stk.Pop() : obj.Value;
            var dict = val.Dict;
            if (0 == t_size) t_size = dict[PN.SIZE].IntValue;
            if (0 == t_root) t_root = dict[PN.ROOT].Ref.Index;
            if (0 == t_info) t_info = dict[PN.INFO].Ref.Index;
            if (dict.ContainsKey(PN.PREV)) ReadXrefTable(br, dict[PN.PREV].LongValue);
            return true;
        }

        public bool ReadRoot(BinaryReader br)
        {
            ClearXrefTable();
            if (! GetHeader(br)) return false;
            long pos = GetStartXref(br);
            if (0 == pos) return false;
            if (! ReadXrefTable(br, pos)) return false;
            //UpdateXrefList();
            return true;
        }

            // byte lf = 0x0a;
            // short crlf = 0x0a0d;
            // byte[] w_data = Encoding.ASCII.GetBytes("%"+FileType+"\n");
                // bw.Write(w_data);
                    // ReadLine(br);
                    // byte[] line = ReadLine(br);
                    // if (line[0] == '%') {
                    //     bw.Write(line);
                    //     bw.Write(crlf);
                    // }
                    // while (true) {
                    //     line = ReadLine(br);
                    //     if (null == line) break;
                    //     bw.Write(line);
                    //     bw.Write(lf);
                    // }

        /////////////////////////////////////////////////////////////////////
        public void WriteLine(BinaryWriter bw, string s)
        {
            bw.Write(Encoding.ASCII.GetBytes(s));
            bw.Write(PC.LF);
        }
        public void Write(BinaryWriter bw, string s)
        {
            bw.Write(Encoding.ASCII.GetBytes(s));
        }
        public void WriteBin(BinaryWriter bw, byte[] ba)
        {
            bw.Write(ba);
        }

        public void WriteHeader(BinaryWriter bw)
        {
            bw.Write(sig);
        }
        public void WriteBody(BinaryWriter bw)
        {
            bw.BaseStream.Seek(firstPos, SeekOrigin.Begin);
            using (var ifs = new FileStream(FilePath, FileMode.Open , FileAccess.Read))
            using (var br = new BinaryReader(ifs))
            {
                br.BaseStream.Seek(firstPos, SeekOrigin.Begin);
                byte[] ba = new byte[BUFSIZE*4];
                int sz;
                while ((sz = br.Read(ba, 0, BUFSIZE*4)) > 0) {
                    bw.Write(ba, 0, sz);
                }
            }
        }
        public void WriteXrefTable(BinaryWriter bw)
        {
            //xref table
            bw.BaseStream.Seek(xrefPos, SeekOrigin.Begin);
            xrefPos = bw.BaseStream.Position;
            WriteLine(bw, PC.XREF);
            WriteLine(bw, ""+p_xrefFirst+" "+p_xrefCount);
            for(int j = 0; j < p_xrefCount; j ++) {
                var idx = xrefList[j];
                var obj = xrefMap[idx];
                string type = (obj.Type == 1) ? PC.N : (obj.Type == 2) ? "c" : PC.F;
                int rev = obj.Revision;
                long pos = obj.Position;
                var s = String.Format("{0:0000000000} {1:00000} {2}", pos, rev, type);
                Write(bw, s);
                Write(bw, " \n");
            }

            //trailer
            WriteLine(bw, PC.TRAILER);
            var dict = PdfValue.CreateDict();
            dict.Add(PN.SIZE, PdfValue.CreateInt(t_size.ToString()));
            dict.Add(PN.ROOT, PdfValue.CreateRef(null, t_root, 0));
            dict.Add(PN.INFO, PdfValue.CreateRef(null, t_info, 0));
            WriteLine(bw, dict.ToString());
        }
        public void WriteStartXref(BinaryWriter bw)
        {
            startPos = bw.BaseStream.Position;
            WriteLine(bw, PC.STARTXREF);
            WriteLine(bw, xrefPos.ToString());
            WriteLine(bw, PC.EOF);
            bw.BaseStream.SetLength(bw.BaseStream.Position);
        }
        public bool SaveAs(string path)
        {
            using (var ofs = new FileStream(path, FileMode.Create , FileAccess.Write))
            using (var bw = new BinaryWriter(ofs))
            {
                WriteHeader(bw);
                WriteBody(bw);
                WriteXrefTable(bw);
                WriteStartXref(bw);
            }
            return true;
        }
  
        /////////////////////////////////////////////////////////////////////
        public bool ReadRoot()
        {
            using (var fs = new FileStream(filePath, FileMode.Open, FileAccess.Read))
            using (var br = new BinaryReader(fs))
            {
                if (! ReadRoot(br)) return false;
                PrintTrailer();
                //root
                Console.WriteLine("-<root>----------------------");
                var root = GetObj(br, t_root);
                if (null == root) return false;
                root.print_value();
                //pages
                Console.WriteLine("-<pages>---------------------");
                var pages = GetObj(br, root.Dict[PN.PAGES].Ref.Index);
                if (null == pages) return false;
                pages.print_value();
                //kids
                Console.WriteLine("-<kids>----------------------");
                var val = pages.Dict[PN.KIDS];
                if (val is ArrayValue) {
                    var o = val.Array;
                    for (int i = 0; i < o.Count; i ++) {
                        int idx = o[i].Ref.Index;
                        var kids = GetObj(br, idx);
                        if (null == kids) return false;
                        kids.print_value();
                    }
                }
                //info
                Console.WriteLine("-<info>----------------------");
                var info = GetObj(br, t_info);
                if (null == info) return false;
                info.print_value();
            }
            return true;
        }
  
        /////////////////////////////////////////////////////////////////////
        public bool ReadTest(int run_mode = 0)
        {
            if (! ReadRoot()) return false;

            Console.WriteLine("");
            Console.WriteLine("#############################");
            Console.WriteLine(fileType + ": " + filePath);
            Console.WriteLine("-----------------------------");
            // PrintXref();
            Console.Write("ROOT "); PrintXref(t_root);
            Console.Write("INFO "); PrintXref(t_info);
            // SaveAs("xxx.pdf");
            return true;
        }
    }
}
