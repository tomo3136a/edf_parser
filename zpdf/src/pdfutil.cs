using System;
using System.IO;
using System.IO.Compression;

namespace Document.Pdf
{
    public class Util
    {
        //////////////////////////////////////////////////////////////////
        //print hex dump
        public static void hexdump(byte[] data, 
            int offset = 0, int size = 0, int n = 32, string pre = null)
        {
            if (pre != null) Console.Write(pre);
            int ps = offset;
            int pe = ps + ((size>0) ? size : data.Length);
            int pc = ps + n;
            for (int i = ps; i < pe; i ++)
            {
                if (i == pc) { Console.WriteLine(); pc += n; }
                Console.Write(string.Format("{0:X2} ", data[i]));
            }
            Console.WriteLine();
        }

        //////////////////////////////////////////////////////////////////
        //read stream
        public static byte[] GetStreamData(
            byte[] src, int offset, int size, 
            int filter, int predictor, int columns)
        {
            byte[] dst = null;
            switch (filter) {
                case 1: break; //ASCIIHexDecode
                case 2: break; //ASCII85Decode
                case 3: break; //LZWDecode
                case 4: //FlateDecode
                dst = FlateDecode(src, offset, size, predictor, columns);
                break;
                case 5: break; //RunLengthDecode
                case 6: break; //CCITTFaxDecode
                case 7: break; //JBIG2Decode
                case 8: break; //DCTDecode
                case 9: break; //JPXDecode
                case 10: break; //Crypt
                default:
                dst = new byte[size];
                Array.Copy(src, offset, dst, 0, size);
                break;
            }
            return dst;
        }

        static byte[] FlateDecode(
            byte[] src, int offset, int size, 
            int predictor, int columns)
        {
            using (var ss = new MemoryStream(src, offset+2, size-2))
            using (var ds = new DeflateStream(ss, CompressionMode.Decompress))
            using (var ts = new MemoryStream())
            {
                ds.CopyTo(ts);
                if (columns == 0) return ts.GetBuffer();
                long cnt = ts.Length / columns;
                byte[] ba1 = new byte[columns];
                byte[] ba2 = new byte[columns];
                ts.Position = 0;
                using (var dst = new MemoryStream())
                {
                    switch (predictor) {
                        case 12:
                        for (int i = 0; i < cnt; i ++) {
                            if (ts.ReadByte() != 2) break;
                            ts.Read(ba1, 0, ba1.Length);
                            for (int j = 0; j < columns; j ++) {
                                ba2[j] += ba1[j];
                            }
                            dst.Write(ba2, 0, ba2.Length);
                        }
                        break;
                    }
                    return dst.GetBuffer();
                }
            }
        }
    }
}
