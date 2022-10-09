# XFDF�t�@�C���t�H�[�}�b�g(�e�L�X�g)

`<annots>` ���Ƀe�L�X�g�v�f��z�u����B

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
        <annots>
          <text .../>           <!-- �m�[�g���� -->
          <freetext .../>       <!-- �e�L�X�g�{�b�N�X -->
            ...
        </annots>
        ...
    </xfdf>
```

�e�L�X�g�v�f�ɂ͎��̎�ނ�����B

* �m�[�g���� `text`
* �e�L�X�g���߁E�e�L�X�g�{�b�N�X�E�����o�����t���e�L�X�g�{�b�N�X `freetext`

---

## �m�[�g����

�m�[�g���߂́A�A�C�R����z�u���A�A�C�R����I�����邱�Ƃɂ��e�L�X�g��\������B  
�m�[�g���߂́A `<text ...>` �v�f���g�p����B

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
* �I�����\������e�L�X�g������� `<contents-richtext>` �܂��� `<contents>` �Ɏw�肷��

---

## �e�L�X�g���߁E�e�L�X�g�{�b�N�X

���R�ɔz�u�ł���e�L�X�g�ɂ́A `<freetext ...>` �v�f���g�p����B  
�ʏ�̓e�L�X�g�{�b�N�X(�g�ň͂񂾃e�L�X�g)�ł��邪�A `width="0.0"` ���w�肷�邱�Ƃɂ��g�̂Ȃ��e�L�X�g���߂ƂȂ�B

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
            font: KozMinPr6N-Regular 12.0pt;font-stretch:Normal;
            text-align:left; color:#000000 
        </defaultstyle>
    </freetext>
```

* `width` �g�̕�(�P�ʂ̓|�C���g) ���ȗ�����1�|�C���g��
* `IT` ��ʕ\����ύX����
  * `IT="FreeTextTypewriter"` �^�C�v���C�^
* `rect` �e�L�X�g�̕\���̈���w�肷��
* �e�L�X�g������� `<contents-richtext>` �܂��� `<contents>` �Ɏw�肷��
* `defaultappearance` ��̃t�H���g���w�肷��
* `defaultstyle` ��̃X�^�C�����w�肷��

(�t�H���g�̎w�肪��������璷�����A�K�v�Ȃ̂��͕s��)

---

## �e�L�X�g������

�e�L�X�g������́A`<contents ...>` �܂��� `<contents-richtext ...>` �Ŏw�肷��B

`<contents>`�v�f���g�p����ꍇ�́A�P���ȃe�L�X�g�f�[�^�Ƃ��Ĉ����B

`<contents-ritchtext>`�v�f���g�p�����ꍇ�A���b�`�e�L�X�g���g�p�ł���B  
���b�`�e�L�X�g�� xhtml �̃T�u�Z�b�g�Ŏw�肵�A�t�H���g�̎w��Ȃǃe�L�X�g�̕\�����w��ł���B  
�������A���b�`�e�L�X�g�Ƃ��Ĉ������P���ȃe�L�X�g�f�[�^�Ƃ��Ĉ������́A�l���������ɂ��B

```xml
    <contents-richtext>
        <body xmlns="http://www.w3.org/1999/xhtml"
            xmlns:xfa="http://www.xfa.org/schema/xfa-data/1.0/" 
            xfa:APIVersion="Acrobat:21.7.0" 
            xfa:spec="2.0.2" 
            style="font-size:12.0pt;text-align:left;color:#000000;
            font-weight:normal;font-style:normal;
            font-family:KozMinPr6N-Regular;
            font-stretch:normal">
            <p dir="ltr">
                <span style="line-height:16.2pt;
                    font-family:'Kozuka Mincho Pr6N R'">�e�L�X�g</span>
            </p>
        </body>
    </contents-richtext>
```

xml ���O��Ԃ́A`http://www.w3.org/1999/xhtml` ���w�肵�Axhtml �̃T�u�Z�b�g���g�p���邱�Ƃ��o����B  
xml ���O��Ԃ́A`http://www.xfa.org/schema/xfa-data/1.0/` ���w�肵�A `xfa:APIVersion` �� `xfa:spec` ���g�p���邱�Ƃ��o����B  
xml ���O��ԁAxml ���O��ԁA�����`xfa:APIVersion` �� `xfa:spec` �̒l�Ƃ̑g�ݍ��킹�͒�^�ł���B���̒�`�ȊO�̏ꍇ�́A�Ӑ}�����\�����o���Ȃ��\��������B
