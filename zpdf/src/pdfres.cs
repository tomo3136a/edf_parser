using System;
using System.Collections.Generic;

namespace Document.Pdf
{
    public class Constant
    {
        /* character */
        public const byte NL = 0;
        public const byte HT = 9;
        public const byte LF = 10;
        public const byte FF = 12;
        public const byte CR = 13;
        public const byte SP = 32;
        public readonly byte[] SPCR = {SP, CR};
        public readonly byte[] SPLF = {SP, LF};
        public readonly byte[] CRLF = {CR, LF};
        public readonly byte[] SPACE = {NL, HT, LF, FF, CR, SP};

        public const byte LP = 0x28; //LEFT PARENTHESIS
        public const byte RP = 0x29; //RIGHT PARENTHESIS
        public const byte LT = 0x3C; //LESS-THAN SIGN
        public const byte GT = 0x3E; //GREATER-THAN SIGN
        public const byte LS = 0x5B; //LEFT SQUARE BRACKET
        public const byte RS = 0x5D; //RIGHT SQUARE BRACKET
        public const byte LC = 0x7B; //LEFT CURLY BRACKET
        public const byte RC = 0x7D; //RIGHT CURLY BRACKET
        public const byte SL = 0x2F; //SOLIDUS
        public const byte PS = 0x25; //PERCENT SIGN

        /* file type */
        public const string PDF = "PDF";
        public const string FDF = "FDF";

        /* file structure */
        public const string SIG_PDF = "%PDF-";
        public const string SIG_FDF = "%FDF-";
        public const string EOF = "%%EOF";

        /* xref */
        public const string XREF = "xref";
        public const string N = "n";
        public const string F = "f";
        public const string STARTXREF = "startxref";
        public const string TRAILER = "trailer";

        /* object */
        public const string OBJ = "obj";
        public const string ENDOBJ = "endobj";
        public const string R = "R";

        /* stream */
        public const string STREAM = "stream";
        public const string ENDSTREAM = "endstream";

        /* value */
        public const string NULL = "null";
        public const string TRUE = "true";
        public const string FALSE = "false";
    }

    public class Name
    {
        //Linerized
        public const string LINEARIZED = "/Linearized";
        public const string L = "/L";
        public const string O = "/O";
        public const string E = "/E";
        public const string N = "/N";
        public const string T = "/T";

        //Common
        public const string TYPE = "/Type";
        public const string SUBTYPE = "/SubType";

        //Catalog
        public const string CATALOG = "/Catalog";
        public const string VERSION = "/Version";
        public const string EXTENTIONS = "/Extensions";
        public const string PAGES = "/Pages";
        public const string PAGELABELS = "/PageLabels";
        public const string NAMES = "/Names";
        public const string DESTS = "/Dests";
        public const string VIEWERPREFERENCES = "/ViewerPreferences";
        public const string OUTLINES = "/Outlines";
        public const string THREADS = "/Threads";
        public const string OPENACTION = "/OpenAction";
        public const string AA = "/AA";
        public const string URI = "/URI";
        public const string ACROFORM = "/AcroForm";
        public const string METADATA = "/Metadata";
        public const string STRUCTTREEROOT = "/StructTreeRoot";
        public const string MARKINFO = "/MarkInfo";
        public const string MARKED = "/Marked";
        public const string  LANG = "/Lang";
        public const string  SPIDERINFO = "/SpiderInfo";
        public const string  OUTPUTINTENTS = "/OutputIntents";
        public const string  PIECEINFO = "/PieceInfo";
        public const string  OCPROPERTIES = "/OCProperties";
        public const string  PERMS = "/Perms";
        public const string  LEAGAL = "/Legal";
        public const string  REQUIREMENTS = "/Requirements";
        public const string  COLLECTION = "/Collection";
        public const string  NEEDRENDERING = "/NeedsRendering";

        //PageLayout
        public const string PAGELAYOUT = "/PageLayout";
        public const string SINGLEPAGE = "/SinglePage";
        public const string ONECOLUMN = "/OneColumn";
        public const string TWOCOLUMNLEFT = "/TwoColumnLeft";
        public const string TWOCOLUMNRIGHT = "/TwoColumnRight";
        public const string TWOPAGELEFT = "/TwoPageLeft";
        public const string TWOPAGERIGHT = "/TwoPageRight";

        //PageMode
        public const string PAGEMODE = "/PageMode";
        public const string USENONE = "/UseNone";
        public const string USEOUTLINES = "/UseOutlines";
        public const string USETHUMBS = "/UseThumbs";
        public const string FULLSCREEN = "/FullScreen";
        public const string USEOC = "/UseOC";
        public const string USEATTACHMENTS = "/UseAttachments";

        //Pages
        public const string PARENT = "/Parent";
        public const string KIDS = "/Kids";
        public const string COUNT = "/Count";

        //Page
        public const string PAGE = "/Page";
        public const string LASTMODIFIED = "/LastModified";
        public const string RESOURCES = "/Resources";
        public const string MEDIABOX = "/MediaBox";
        public const string CROPBOX = "/CropBox";
        public const string BLEEDBOX = "/BleedBox";
        public const string TRIMBOX = "/TrimBox";
        public const string ARTBOX = "/ArtBox";
        public const string BOXCOLORINFO = "/BoxColorInfo";
        public const string CONTENTS = "/Contents";
        public const string ROTATE = "/Rotate";
        public const string GROUP = "/Group";
        public const string THUMB = "/Thumb";
        public const string B = "/B";


        public const string DUR = "/Dur";
        public const string TRUNS = "/Trans";
        public const string ANNOTS = "/Annots";
        public const string STRUCTPARENTS = "/StructParents";
        public const string PZ = "/PZ";
        public const string SEPARATIONINFO = "/SeparationInfo";
        public const string TABS = "/Tabs";
        public const string TEMPLATEINSTANTIATED = "/TemplateInstantiated";
        public const string PRESSTEPS = "/PresSteps";
        public const string USERUNIT = "/UserUnit";
        public const string VP = "/VP";

        public const string OBJSTM = "/ObjStm";
        //public const string N = "/N";
        public const string FIRST = "/First";
        public const string EXTENDS = "/Extends";

        public const string XREF = "/XRef";
        public const string INDEX = "/Index";
        public const string W = "/W";

        public const string SUBFILTER = "/SubFilter";
        public const string V = "/V";
        public const string CF = "/CF";
        public const string STMF = "/StmF";
        public const string STRF = "/StrF";
        public const string EFF = "/EFF";

        public const string SIZE = "/Size";
        public const string ROOT = "/Root";
        public const string INFO = "/Info";
        public const string PREV = "/Prev";
        public const string ENCRYPT = "/Encrypt";
        public const string ID = "/ID";

        //stream common
        public const string LENGTH = "/Length";
        public const string FILTER = "/Filter";
        public const string DECODEPARMS = "/DecodeParms";
        public const string F = "/F";
        public const string FFILTER = "/FFilter";
        public const string FDECODEPARMS = "/FDecodeParms";
        public const string DL = "/DL";

        // public const string ASCIIHEXDECODE = "/ASCIIHexDecode";
        // public const string ASCII85DECODE = "/ASCII85Decode";
        // public const string LZWDECODE = "/LZWDecode";
        public const string FLATEDECODE = "/FlateDecode";
        // public const string RUNLENGTHDECODE = "/RunLengthDecode";
        // public const string CCITTFAXDECODE = "/CCITTFaxDecode";
        // public const string JBIG2DECODE = "/JBIG2Decode";
        // public const string DCTDECODE = "/DCTDecode";
        // public const string JPXDECODE = "/JPXDecode";
        // public const string CRYPT = "/Crypt";
        public const string PREDICTOR = "/Predictor";
        public const string COLORS = "/Colors";
        public const string BITSPERCOMPONENT = "/BitsPerComponent";
        public const string COLUMNS = "/Columns";
        public const string EARLYCHANGE = "/EarlyChange";
        public const string K = "/K";
    }
}
