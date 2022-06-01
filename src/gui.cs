#define DEBUG

using System;
using System.IO;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;

namespace hwutils
{
    /////////////////////////////////////////////////////////////////////
    // dialog

    public class SetupDialog : Form
    {
        Button accept = new Button();
        Button cancel = new Button();
        Label textLabel = new Label();
        Label src1Name = new Label();
        TextBox src1Box = new TextBox();
        Button src1Btn = new Button();
        Label src2Name = new Label();
        TextBox src2Box = new TextBox();
        Button src2Btn = new Button();
        Label xslName = new Label();
        TextBox xslBox = new TextBox();
        Button xslBtn = new Button();
        Label[] dtName = new Label[3];
        TextBox[] kyBox = new TextBox[3];
        TextBox[] dtBox = new TextBox[3];
        Button[] dtBtn = new Button[3];

        Label modeLabel = new Label();
        ComboBox comboBox = new ComboBox();

        public SetupDialog(string text, string caption)
        {
            int width = 500;
            int height = 260;
            int g = 10;

            this.Width = width;
            this.Height = height;
            //this.FormBorderStyle = FormBorderStyle.FixedDialog;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.ShowIcon = false;
            this.Text = caption;
            this.MinimumSize = new Size(width, height);
            this.StartPosition = FormStartPosition.CenterScreen;
            int w = this.ClientRectangle.Width;
            int h = this.ClientRectangle.Height;

            cancel.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            cancel.Text = "Cancel";
            cancel.Width = 100;
            cancel.Left = w - g - cancel.Width;
            cancel.Top = h - g - cancel.Height;
            cancel.DialogResult = DialogResult.Cancel;
            cancel.Click += new EventHandler(on_close);

            accept.Anchor = AnchorStyles.Bottom | AnchorStyles.Right;
            accept.Text = "Ok";
            accept.Width = cancel.Width;
            accept.Left = cancel.Left - g - accept.Width;
            accept.Top = cancel.Top;
            accept.DialogResult = DialogResult.OK;
            accept.Click += new EventHandler(on_close);

            textLabel.Text = text;
            textLabel.AutoSize = true;
            textLabel.Left = g;
            textLabel.Top = g;
            int h2 = 5;
            int w2 = 44;

            // source 1
            src1Name.Text = "Source";
            src1Name.Left = g;
            src1Name.Top = g + textLabel.Height;
            src1Name.AutoSize = true;

            src1Btn.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            src1Btn.Text = "Select";
            src1Btn.AutoSize = true;
            src1Btn.Left = w - g - src1Btn.Width;
            src1Btn.Top = src1Name.Top - h2;
            src1Btn.Click += new EventHandler(on_src1);

            src1Box.Anchor = AnchorStyles.Top | AnchorStyles.Bottom 
                | AnchorStyles.Left | AnchorStyles.Right;
            src1Box.AutoSize = true;
            src1Box.Width = w - 3 * g - src1Btn.Width - w2;
            src1Box.Left = g + w2;
            src1Box.Top = src1Btn.Top + (src1Btn.Height - src1Box.Height);

            // source 2
            src2Name.Text = "Source";
            src2Name.Left = g;
            src2Name.Top = src1Name.Top + src1Name.Height + g;
            src2Name.AutoSize = true;

            src2Btn.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            src2Btn.Text = "Select";
            src2Btn.AutoSize = true;
            src2Btn.Left = w - g - src2Btn.Width;
            src2Btn.Top = src2Name.Top - h2;
            src2Btn.Click += new EventHandler(on_src2);

            src2Box.Anchor = AnchorStyles.Top | AnchorStyles.Bottom 
                | AnchorStyles.Left | AnchorStyles.Right;
            src2Box.AutoSize = true;
            src2Box.Width = w - 3 * g - src2Btn.Width - w2;
            src2Box.Left = g + w2;
            src2Box.Top = src2Btn.Top + (src2Btn.Height - src2Box.Height);

            // xsl
            xslName.Text = "Xsl";
            xslName.Left = g;
            xslName.Top = src2Name.Top + src2Name.Height + g;
            xslName.AutoSize = true;

            xslBtn.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            xslBtn.Text = "Select";
            xslBtn.AutoSize = true;
            xslBtn.Left = w - g - xslBtn.Width;
            xslBtn.Top = xslName.Top - h2;
            xslBtn.Click += new EventHandler(on_xsl);

            xslBox.Anchor = AnchorStyles.Top | AnchorStyles.Bottom 
                | AnchorStyles.Left | AnchorStyles.Right;
            xslBox.AutoSize = true;
            xslBox.Width = w - 3 * g - xslBtn.Width - w2;
            xslBox.Left = g + w2;
            xslBox.Top = xslBtn.Top + (xslBtn.Height - xslBox.Height);

            // data
            dtName[0] = new Label();
            kyBox[0] = new TextBox();
            dtBox[0] = new TextBox();
            dtBtn[0] = new Button();
            dtName[0].Text = "data";
            dtName[0].Left = g;
            dtName[0].Top = xslName.Top + xslName.Height + g;
            dtName[0].AutoSize = true;

            dtBtn[0].Anchor = AnchorStyles.Top | AnchorStyles.Right;
            dtBtn[0].Text = "Select";
            dtBtn[0].AutoSize = true;
            dtBtn[0].Left = w - g - dtBtn[0].Width;
            dtBtn[0].Top = dtName[0].Top - h2;
            dtBtn[0].Click += new EventHandler(on_dt);

            kyBox[0].Anchor = AnchorStyles.Top | AnchorStyles.Bottom 
                | AnchorStyles.Left | AnchorStyles.Right;
            kyBox[0].AutoSize = true;
            kyBox[0].Width = 50;
            kyBox[0].Left = g + w2;
            kyBox[0].Top = dtBtn[0].Top + (dtBtn[0].Height - dtBox[0].Height);

            dtBox[0].Anchor = AnchorStyles.Top | AnchorStyles.Bottom 
                | AnchorStyles.Left | AnchorStyles.Right;
            dtBox[0].AutoSize = true;
            dtBox[0].Width = w - 3 * g - dtBtn[0].Width - w2 - g - 50;
            dtBox[0].Left = g + w2 + 50 + g;
            dtBox[0].Top = dtBtn[0].Top + (dtBtn[0].Height - dtBox[0].Height);

            // others
            // modeLabel.AutoSize = true;
            // modeLabel.Anchor = AnchorStyles.Top | AnchorStyles.Right;
            // modeLabel.Text = "";
            // modeLabel.Left = w - g - modeLabel.Width;
            // modeLabel.Top = g;
            // // modeLabel.Click += new EventHandler(on_mode);
            // modeLabel.Visible = false;

            // comboBox.Anchor = AnchorStyles.Bottom | AnchorStyles.Left;
            // comboBox.Left = g;
            // comboBox.Top = h - g - accept.Height;
            // comboBox.Visible = false;

            this.Controls.Add(textLabel);
            this.Controls.Add(modeLabel);
            this.Controls.Add(accept);
            this.Controls.Add(cancel);
            this.Controls.Add(src1Name);
            this.Controls.Add(src1Box);
            this.Controls.Add(src1Btn);
            this.Controls.Add(src2Name);
            this.Controls.Add(src2Box);
            this.Controls.Add(src2Btn);
            this.Controls.Add(xslName);
            this.Controls.Add(xslBox);
            this.Controls.Add(xslBtn);

            this.Controls.Add(dtName[0]);
            this.Controls.Add(kyBox[0]);
            this.Controls.Add(dtBox[0]);
            this.Controls.Add(dtBtn[0]);
            this.ActiveControl = src1Box;

            // this.Controls.Add(comboBox);
            this.AcceptButton = accept;
            this.CancelButton = cancel;
        }

        void on_close(Object sender, EventArgs e)
        {
            this.Close();
        }

        public string Source1 {
            get { return src1Box.Text; }
            set { src1Box.Text = value; }
        }

        public string Source2 {
            get { return src2Box.Text; }
            set { src2Box.Text = value; }
        }

        public string Xsl {
            get { return xslBox.Text; }
            set { xslBox.Text = value; }
        }

        public string Key1 {
            get { return kyBox[0].Text; }
            set { kyBox[0].Text = value; }
        }

        public string Data1 {
            get { return dtBox[0].Text; }
            set { dtBox[0].Text = value; }
        }

        string src_flt = "source files (*.edf;*.edif;*.xedf)|*.edf;*.edif;*.xedf" + 
            "|edif files (*.edf;*.edif)|*.edf;*.edif" + "|xml edif files (*.xedf)|*.xedf"+ 
            "|xml files (*.xml)|*.xml" + "|All files (*.*)|*.*";
        string xsl_flt = "xsl files (*.xsl)|*.xsl";
        string txt_flt = "text files (*.txt)|*.txt" + "|All files (*.*)|*.*";

        bool select_source(TextBox tb, string flt)
        {
            OpenFileDialog dlg = new OpenFileDialog();
            string path = tb.Text;
            path = (path.Length > 0) ? path : ".\\";
            dlg.InitialDirectory = Path.GetDirectoryName(path);
            dlg.FileName = Path.GetFileName(path);
            dlg.Filter = flt;
            dlg.FilterIndex = 1;
            dlg.RestoreDirectory = true;
            if (dlg.ShowDialog() == DialogResult.OK)
            {
                tb.Text = dlg.FileName;
                return true;
            }
            return false;
        }

        void on_src1(Object sender, EventArgs e)
        {
            select_source(this.src1Box, src_flt);
        }

        void on_src2(Object sender, EventArgs e)
        {
            select_source(this.src2Box, src_flt);
        }

        void on_xsl(Object sender, EventArgs e)
        {
            select_source(this.xslBox, xsl_flt);
        }

        void on_dt(Object sender, EventArgs e)
        {
            select_source(this.dtBox[0], txt_flt);
        }

    }

    /////////////////////////////////////////////////////////////////////////

    // class Program
    // {
    //     // private static void SetDebugLogFileName(string path)
    //     // {
    //     //     var p = Debug.Listeners["Default"];
    //     //     ((DefaultTraceListener)p).LogFileName = path;
    //     // }

    //     [STAThread]
    //     public static void Main2(string[] args)
    //     {
    //         SetDebugLogFileName(@".\\debug.txt");
    //         Debug.WriteLine("test debug");
    //         try
    //         {
    //             string title = "indexed";
    //             string text = "É^ÉOÇì¸ÇÍÇƒÇ≠ÇæÇ≥Ç¢ÅB";
    //             SetupDialog dlg = new SetupDialog(text, title);
    //             // dlg.Value = tag;
    //             if (dlg.ShowDialog() == DialogResult.OK)
    //             {
    //                 string src1 = dlg.Source1;
    //                 string src2 = dlg.Source2;
    //             }
    //         }
    //         catch
    //         {
    //             MessageBox.Show("error.");
    //         }
    //         Debug.Flush();
    //     }
    // }
}
