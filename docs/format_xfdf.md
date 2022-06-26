# XFDF�t�@�C���t�H�[�}�b�g

## �T�v

XFDF �t�@�C���́A FDF �t�@�C���� XML �t�@�C���łł���B
�t�H�[���f�[�^�ƒ��߂�ۑ�����B

## �g���q

`.xfdf`

## example

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
        <annots>
            <square width="9.000000" color="#E52237" opacity="0.494995"
                creationdate="D:20211219185715+09'00'" flags="print"
                interior-color="#FFAABF" 
                date="D:20211219191624+09'00'"
                name="f4873cca-4d0f-47fb-8be9-ded59e5dabaa"
                page="0" fringe="4.500000,4.500000,4.500000,4.500000" 
                rect="0.500000,1.500000,611.500000,791.500000" 
                subject="�����`" title="tomo3">
                <popup flags="print,nozoom,norotate" open="no" page="0" 
                    rect="612.000000,673.000000,816.000000,787.000000"/>
            </square>
        </annots>
        <f href="xxx.pdf"/>
        <ids original="D44B3069C43280202DC5423980241179" 
            modified="B45F09C7D1006DEBF9E6EC5B88B0E834"/>
    </xfdf>
```

## ���[�g

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
        ...
        <f href="xxx.pdf"/>
        <ids original="D44B3069C43280202DC5423980241179" 
            modified="B45F09C7D1006DEBF9E6EC5B88B0E834"/>
    </xfdf>
```

* root�́A`<xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">`�Ƃ���
* `<f href="...">` ��pdf�t�@�C���ւ̃����N�B�����Ă��悢�B
* `<ids original="..." modified="...">` ��pdf�t�@�C���ւ̃����N���B�����Ă��悢�B
* `<xfdf ...>`�̉��Ƀt�H�[��`<fields>`��R�����g`<annots>`��z�u����B

## �t�H�[���f�[�^

`<fields>` ���Ƀt�H�[���f�[�^��z�u����B

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
        <fields>
            ...
        </fields>
        <f href="xxx.pdf"/>
        <ids original="D44B3069C43280202DC5423980241179" 
            modified="B45F09C7D1006DEBF9E6EC5B88B0E834"/>
    </xfdf>
```

### �P���t�H�[���f�[�^

�t�H�[���f�[�^�́A`<field ...>`��`name`�������L�[�Ƃ��A`<value>`�ɒl���w�肷��B

```xml
    <fields>
        <field name=�hName�h>
            <value>Adobe Systems, Inc.</value>
        </field>
        <field name=�hStreet�h>
            <value>345 Park Ave.</value>
        </field>
        ...
    </fields>
```

### �K�w�\��

`<field>`�͓���q�ɂł��A�O���[�s���O�ł���B

```xml
    <fields>
        <field name=�hAddress�h>
            <field name=�hName�h>
                <value>Adobe Systems, Inc.</value>
            </field>
            <field name=�hStreet�h>
                <value>345 Park Ave.</value>
            </field>
            ...
        </field>
    </fields>
```

�l�́A`<value>`�̑����`<value-ritchtext>`���g�p����ƃ��b�`�e�L�X�g�Ƃ��Ďg�p�ł���B

```xml
    <value-richtext>
        <body xmlns="http://www.w3.org/1999/xhtml"
            xmlns:xfa="http://www.xfa.org/schema/xfa-data/1.0/" 
            xfa:APIVersion="Acrobat:21.7.0" 
            xfa:spec="2.0.2">
            <p>
                <span style="font-size:10.0pt"><i>���b�`</i>�e�L�X�g</span>
            </p>
        </body>
    </value-richtext>
```

## �R�����g

`<annots>` ���ɃR�����g�u���b�N��z�u����B

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
        <annots>
            ...
        </annots>
        <f href="xxx.pdf"/>
        <ids original="D44B3069C43280202DC5423980241179" 
            modified="B45F09C7D1006DEBF9E6EC5B88B0E834"/>
    </xfdf>
```

* �R�����g�u���b�N��`<annots>`���ɔz�u����B��ȃR�����g�u���b�N�ɂ͎��̎�ނ�����B
  * �e�L�X�g�ɏC��
    * �n�C���C�g `highlight`
    * ���� `underline`
    * �g���� `squiggly`
    * �������� `strikeout`
  * �e�L�X�g�̍Z��
    * �}���e�L�X�g `caret`
  * �e�L�X�g
    * �m�[�g���� `text`
    * �e�L�X�g���߁E�e�L�X�g�{�b�N�X�E�����o�����t���e�L�X�g�{�b�N�X `freetext`
  * �}�`
    * ���E���� `line`
    * �l�p�` `square`
    * �~�E�ȉ~ `circle`
    * ���p�` `polygon`
    * �܂�� `polyline`
    * ���R�Ȑ� `ink`
  * �X�^���v `stamp`
  * �|�b�v�A�b�v�m�[�g `popup`
  * ���̑� `fileattachiment`,`sound`,`link`,`redact`,`projection`,`movie`,
    `widget`,`screen`,`printmark`,`trapnet`,`richmedia`,`3d`,`watermark`

## �R�����g�u���b�N�̋��ʑ���

�R�����g�u���b�N�ŋ��ʂ��Ďg�p����鑮���ɂ́A�ȉ�������B

* `color` �F(#rrggbb) ���ȗ����͘g�Ȃ�
* `opacity` �����x(0.0�`1.0,�����_�\�L) ���ȗ����͕s����(=1.0)
* `date`, `creationdate` ���t(�ȗ���)
  ��`date`���ȗ�����ƍX�V����`�s��`�\���ɂȂ�̂ŏȗ����Ȃ��ق����ǂ�
* `flags` �t���O(��������ꍇ�̓J���}��؂�)
  * `hidden` ��\���w��
  * `print` ����Ώ�
  * `locked` ���b�N�w��
  * `nozoom`
  * `norotate`
* `name` �R�����g�u���b�N�̖��O(�ȗ���)
* `page` �R�����g�u���b�N��\������y�[�W
* `rect` �R�����g�u���b�N��\������̈�S�͈̔�
* `subject` �R�����g�u���b�N�̃T�u�W�F�N�g(�ȗ���)
* `title` �R�����g�u���b�N�̃^�C�g���E�쐬�Җ�(�ȗ���)
* �e�u���b�N�ɂ̓|�b�v�A�b�v�m�[�g��݂��邱�Ƃ��ł���B `<popup ...>`

## ������C��(�n�C���C�g,�A���_�[���C��,��������)

* �n�C���C�g�́A`<highlight ...>` �Ŏw�肷��B
* �����́A`<underline ...>` �Ŏw�肷��B
* �g�����́A`<squiggly ...>`�Ŏw�肷��B
* ���������́A`<strikeout ...>`�Ŏw�肷��B
* `coords`�����Ŏw�肷��͈͂Ƀe�L�X�g������Ƃ��̂Ƃ��ďC������B\
  �l�� "x1,y1,x2,y2,x3,y3,x4,y4" �ƍ��W���J���}��؂�ŕ\���B\
  (x1,y1)-(x2,y2)�̒�����(x3,y3)-(x4,y4)�̒����̊Ԃ�1�̃e�L�X�g�͈͂Ƃ���B\
  �����ĕ����w�肷�邱�Ƃɂ�蕡���s��Ώۂɏo����
* `IT` ��ʕ\����ύX����
  * `IT="HighlightNote"` �n�C���C�g�m�[�g

## �L�����b�g

�����Ԃɑ΂��ăR�����g����B�Z���Ɏg�p����B
�Z���́A��{�I�ɂ́u�������v�u�}���v�u�u���v�𖾎�����B\
�u�������v�͎����������g�p����B\
�u�}���v�̓L�����b�g�Ƀe�L�X�g������B\
�u�u���v�́A�u�������v�Ɓu�}���v����ׂ����̂ɂȂ�B

* `IT` ��ʕ\����ύX����
  * `IT="Replace"` �u���e�L�X�g
  * `IT="StrikeOutTextEdit"` ��������
* `fringe`
* `content-richtext`

## �m�[�g����

�m�[�g���߂́A�A�C�R����z�u���A�A�C�R����I������ƃm�[�g��\������B
�m�[�g���߂́A `<text ...>` ���g�p����B

```xml
    <text 
        color="#FFD100" 
        icon="Comment" 
        page="0" 
        rect="100.000000,76.000000,124.000000,100.000000" >
        <contents-richtext>
            <body xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xfa="http://www.xfa.org/schema/xfa-data/1.0/" 
                xfa:APIVersion="Acrobat:21.7.0" xfa:spec="2.0.2">
                <p>�m�[�g</p>
            </body>
        </contents-richtext>
    </text>
```

* `icon` �A�C�R�����w�肷��
  * �ȗ��� �m�[�g
  * `"Check"` �`�F�b�N�}�[�N
  * `icon="Checkmark"` �e�L�X�g��}��
  * `icon="Circle"` �~�`
  * `icon="Comment"` �R�����g
  * `icon="Cross"` �\���^
  * `icon="CrossHairs"` �\���A�C�R��
  * `icon="Help"` �w���v
  * `icon="Insert"` �e�L�X�g��}��
  * `icon="Key"` �L�[
  * `icon="NewParagraph"` �V�K�i��
  * `icon="Paragraph"` �i��
  * `icon="RightArrow"` �E�������
  * `icon="RightPointer"` �E�����|�C���^�[
  * `icon="Star"` ���`
  * `icon="UpArrow"` ��������
  * `icon="UpLeftArrow"` ����������
* `rect` �A�C�R���̕\���̈���w�肷��
* �I�����\������e�L�X�g������� `<contents-richtext>` �Ɏw�肷��

## �e�L�X�g���߁E�e�L�X�g�{�b�N�X

���R�ɔz�u�ł���e�L�X�g�ɂ́A `<freetext ...>` ���g�p����B\
��{�̓e�L�X�g�{�b�N�X(�g�ň͂񂾃e�L�X�g)�ł��邪�A `width="0.0"` ���w�肷�邱�Ƃɂ��g�Ȃ��̃e�L�X�g�ƂȂ�B

```xml
    <freetext 
        width="0.000000" 
        IT="FreeTextTypewriter" 
        page="0" 
        rect="128.010803,646.210144,176.020813,662.470154" >
        <contents-richtext>
            <body xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xfa="http://www.xfa.org/schema/xfa-data/1.0/" 
                xfa:APIVersion="Acrobat:21.7.0" xfa:spec="2.0.2"
                style="font-size:12.0pt;text-align:left;color:#000000;
                    font-weight:normal;font-style:normal;
                    font-family:KozMinPr6N-Regular;font-stretch:normal">
                <p>�e�L�X�g</p>
            </body>
        </contents-richtext>
        <defaultappearance>16.25 TL /MSGothic 12 Tf</defaultappearance>
        <defaultstyle>
            font: KozMinPr6N-Regular 12.0pt;font-stretch:Normal; text-align:left; color:#000000 
        </defaultstyle>
    </freetext>
```

* `width` �g�̕�(�P�ʂ̓|�C���g) ���ȗ�����1�|�C���g��
* `IT` ��ʕ\����ύX����
  * `IT="FreeTextTypewriter"` �^�C�v���C�^

## �e�L�X�g������

�e�L�X�g�́A�R�����g�u���b�N�̉��ʂ� `<contents-richtext ...>` �Ŏw�肷��B

```xml
    <contents-richtext>
        <body xmlns="http://www.w3.org/1999/xhtml"
            xmlns:xfa="http://www.xfa.org/schema/xfa-data/1.0/" 
            xfa:APIVersion="Acrobat:21.7.0" 
            xfa:spec="2.0.2" 
            style="font-size:12.0pt;text-align:left;color:#000000;
            font-weight:normal;font-style:normal;font-family:KozMinPr6N-Regular;
            font-stretch:normal">
            <p dir="ltr">
                <span style="line-height:16.2pt;font-family:'Kozuka Mincho Pr6N R'">�e�L�X�g����</span>
            </p>
        </body>
    </contents-richtext>
```

## �}�`����

* `width` ����(�P�ʂ̓|�C���g) ���ȗ�����1�|�C���g��
* `style` ���̃X�^�C���w��
  * `"dash"` �j���̎w��
  * `"cloudy"` �_�`�̎w��
* `dashes` �j���̊Ԋu (`width`>2 �ł��Ȃ��Ɛ���ɔF�����Ȃ�)
  * dashes="2.000000,2.000000"
  * dashes="3.000000,3.000000"
  * dashes="4.000000,4.000000"
  * dashes="4.000000,3.000000,2.000000,3.000000"
  * dashes="4.000000,3.000000,16.000000,3.000000"
  * dashes="8.000000,4.000000,4.000000,4.000000"
* `intensity` �_�`�̊Ԋu
  * intensity="1.000000"
  * intensity="2.000000"
* `inter-color` �̈���̐F(#rrggbb) ���ȗ����͗̈�F�Ȃ�
* `fringe` �t�����W(�ȗ���) �ʏ�� `rect` �̗̈�̊O���̗̈敝

## ���E����

���ɕ`���Ȑ��́A `<line ...>` ���g�p����B

```xml
    <line 
        color="#E52237" 
        IT="LineArrow" 
        start="263.389130,266.142761" 
        end="302.989594,238.514526" 
        head="None" 
        tail="OpenArrow" 
        page="0" 
        rect="257.889130,233.014526,307.669464,271.642761" >
    </line>
```

* `start` �J�n���W
* `end` �I�����W

����t����ɂ́A�ȉ���ǉ��B

* `head` �J�n�ʒu�̖��^�C�v (�s�v�Ȃ�ȗ���)
* `tail` �I���ʒu�̖��^�C�v (�s�v�Ȃ�ȗ���)

���̃^�C�v�F

* `"None"` ���Ȃ�
* `"OpenArrow"` �J�������
* `"CloseArrow"` �������
* `"ROpenArrow"` �J�������(������)
* `"RCloseArrow"` �������(������)
* `"Butt"` �ˍ��킹
* `"Diamond"` �Ђ��`
* `"Circle"` �~�`
* `"Square"` �l�p
* `"Slash"` �X���b�V��

��ʕ\����ύX����

* `IT="LineArrow"` �u���v�\��
* `IT="PolygonCloud"` �u�_�`�v�\��

## �l�p�`

�l�p�`�́A`<square ...>`���g�p����B

```xml
    <square 
        color="#E52237" 
        page="0" 
        fringe="0.500000,0.500000,0.500000,0.500000" 
        rect="346.694763,238.014526,400.188385,279.535950" >
    </square>
```

## �~�E�ȉ~

�~�`�́A`<circle ...>`���g�p����B

```xml
    <circle 
        color="#E52237" 
        page="0" 
        fringe="0.500000,0.500000,0.500000,0.500000" 
        rect="447.998260,225.121338,503.333771,266.642761" >
    </circle>
```

## ���p�`

���p�`�́A`<polygon ...>`���g�p����B
���_��`<vertices>`�ɕ��ׂ�B

```xml
    <polygon 
        color="#E52237" 
        page="0" 
        rect="447.998260,225.121338,503.333771,266.642761" >
        <vertices>
            308.515228,262.458984;
            370.218292,231.146973;
            258.784424,153.787964;
            ...
            308.515228,262.458984
        </vertices>
    </polygon>
```

## �܂��

�܂���́A`<polyline ...>`���g�p����B
���_��`<vertices>`�ɕ��ׂ�B

```xml
    <polyline 
        color="#E52237" 
        page="0" 
        rect="106.750107,247.644897,468.838013,374.892853" >
        <vertices>
            107.750107,267.984619;
            118.801392,347.185547;
            163.927490,286.403442;
            ...
            467.838013,248.644897
        </vertices>
    </polyline>
```

## ���R�Ȑ�

���R�ɕ`���Ȑ��́A `<ink ...>` ���g�p����B
�R�����g�u���b�N�̉��ʂ� `<inkList>`�A����ɉ��ʂ� `<gesture>` �ɋȐ��̒ʉߓ_����ׂ�B

```xml
    <inklist>
        <gesture>
            121.564209,339.818024;
            122.485153,341.659912;
            124.327042,344.422729;
            ...
            197.081390,337.055206
        </gesture>
    </inklist>
```

## �X�^���v

�X�^���v�́A `<stamp ...>` ���g�p����B
�X�^���v�́A�A�C�R���̊G��\������B

```xml
    <stamp
        color=�h#FF0000�h
        icon=�hSBApproved�h 
        page=�h0�h 
        rect=�h54.987381,671.039063,216.486893,718.539551�h >
    </stamp>
```

* `icon` �ɃA�C�R���̖��O
  * `SBApproved` ���F�{�^��
  * ... ���낢��

## �|�b�v�A�b�v�m�[�g

�R�����g�u���b�N�̓|�b�v�A�b�v�m�[�g�������Ƃ��ł���B
�e�u���b�N�̉��ʂ� `<popup ...>` ��z�u����B

* `flags` �t���O(��������ꍇ�̓J���}��؂�)
  * `print`
  * `nozoom`
  * `norotate`
* `open` �\�����(`no`:�v������ƊJ���A`yes`:�ŏ�����J���Ă���)
* `page` �\������y�[�W
* `rect` �\������͈�

## ���W

���W�́A�e�y�[�W�̍��������_�Ƃ��đ��ی��z�u����B

## �p��

|paper| paper size(mm) | size(72dpi)     | size(96dpi)     |
|:---:|----------------|-----------------|-----------------|
| A4  | 210mm x 297mm  |  595pt x 842pt  |  794pt x 1123pt |
| A3  | 297mm x 420mm  |  842pt x 1191pt | 1123pt x 1588pt |
| A2  | 420mm x 594mm  | 1191pt x 1684pt | 1588pt x 2246pt |
| A1  | 594mm x 841mm  | 1684pt x 2384pt | 2246pt x 3180pt |
| A0  | 841mm x 1189mm | 2384pt x 3370pt | 3180pt x 4496pt |

### �p���T�C�Y

A0�ł̒�`�F

* `�c[m]*��[m] = 1`  ���ʐ�=1m^2
* `�c[m]/��[m] = sqrt(2)` ��������

`A�ŃT�C�Y�v�Z �c[mm] = floor(1000/2^((2*n-1)/4)+0.2)`  
`A�ŃT�C�Y�v�Z ��[mm] = floor(1000/2^((2*n+1)/4)+0.2)`  
n=0,1,2,3,4,... ���T�C�Y����

### 72dpi �̏ꍇ(Web�\���֌W�W��, pdf)

�P�ʂ̓|�C���g(pt) 72dpi, 1inch=25.4mm, 1inch=72pt  
�� pt(x)=x*72/25.4

### 96dpi �̏ꍇ(�\���֌W�W��, Windows�̏ꍇ)

�P�ʂ̓|�C���g(pt) 96dpi, 1inch=25.4mm, 1inch=96pt  
�� pt(x)=x*96/25.4

96dpi = 72dpi * 4/3

## ���t

`date`������`createdate`�����́A���t���w�肷��B\
`2021�N12��19�� 19��16��24�b +09:00`�́A`"D:20211219191624+09'00'"` �ŕ\���B

## ���

`statemodel` �ŏ�ԃ��f�����w�肵�A`state`�ɏ�Ԃ��w�肷��B

�X�e�[�^�X��`Review`���f�����g�p����

* `statemodel="Review"`
  * `state="None"` �Ȃ�
  * `state="Accepted"` ���F
  * `state="Cancelled"` �L�����Z��
  * `state="Completed"` ����
  * `state="Rejected"` �p��

�`�F�b�N�}�[�N��`Marked`���f�����g�p����

* `statemodel="Marked"`
  * `state="Marked"` �}�[�N�ݒ�
  * `state="Unmarked"` �}�[�N����

## ���v���C

�R�����g�u���b�N��`inreplyto`�����Ŏw�肵�����O�̃R�����g�u���b�N�ւ̃��v���C�Ƃ��Ĉ����B

```xml
    <text 
        name="65ba4fde-e993-45ab-8176-1f60177b948a" >
        <contents-richtext>
            �e�L�X�g
        </contents-richtext>
    </text>

    <text 
        inreplyto="65ba4fde-e993-45ab-8176-1f60177b948a" 
        name="d3a51b32-240c-444a-94a9-ac97ccb23471" >
        <contents-richtext>
            ���v���C�e�L�X�g
        </contents-richtext>
    </text>
```

* `replyType`
  * �ȗ����͕ԐM
  * `replyType="group"` �O���[�v��(�����̃R�����g�u���b�N��1�Ƃ��Ĉ����w��)
