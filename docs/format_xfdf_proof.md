# XFDF�t�@�C���t�H�[�}�b�g(�e�L�X�g�̍Z��)

�Z���́A��{�I�ɂ� �u�������v �u�}���v �u�u���v �𖾎�����B

* �u�������v �͎����������g�p����B
* �u�}���v �̓L�����b�g�Ƀe�L�X�g������B
* �u�u���v �́A �u�������v �� �u�}���v ����ׂ����̂ɂȂ�B

`<annots>` �̎q�v�f�Ƃ��ăe�L�X�g�Z���̗v�f��z�u����B

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
        <annots>
          <highlight .../>    <!-- �n�C���C�g -->
          <underline .../>    <!-- ���� -->
          <squiggly .../>     <!-- �g���� -->
          <strikeout .../>    <!-- �������� -->
          <caret .../>        <!-- �}���e�L�X�g -->
          ...
        </annots>
        ...
    </xfdf>
```

�e�L�X�g�Z���̗v�f�́A���W�ň͂񂾔͈͓��̃e�L�X�g��ΏۂɁA�e��C�����s���B

�e�L�X�g�Z���̗v�f�ɂ͎��̎�ނ�����B

* �e�L�X�g�ɏC��
  * �n�C���C�g `highlight`
  * ���� `underline`
  * �g���� `squiggly`
  * �������� `strikeout`
* �����ԂɏC��
  * �}���e�L�X�g `caret`

---

## �e�L�X�g�ɏC��

�e�L�X�g������ɑ΂��ĕ����C��( �n�C���C�g, ����, �������� )����B

```xml
    <highlight 
      color="#FFD100" 
      opacity="0.399994" 
      page="0" 
      coords="80.000000,589.023804,173.543976,589.023804,
              80.000000,558.774170,173.543976,558.774170" 
      rect="71.924774,557.828857,181.619202,589.969116" >
    </highlight>
```

* �n�C���C�g�́A`<highlight ...>` �v�f�Ŏw�肷��B
* �����́A`<underline ...>` �v�f�Ŏw�肷��B
* �g�����́A`<squiggly ...>` �v�f�Ŏw�肷��B
* ���������́A`<strikeout ...>` �v�f�Ŏw�肷��B

`coords` �����Ŏw�肷��͈͂Ƀe�L�X�g������Ƃ��̂Ƃ��ďC������B  
  �l�� "x1,y1,x2,y2,x3,y3,x4,y4" �ƍ��W���J���}��؂�ŕ\���B  
  (x1,y1)-(x2,y2)�̒�����(x3,y3)-(x4,y4)�̒����̊Ԃ�1�̃e�L�X�g�͈͂Ƃ���B  
  �����ĕ����w�肷�邱�Ƃɂ�蕡���s��Ώۂɏo����

`rect` �����őS�̗̂̈���w�肷��B

`IT` �����Ŏ�ʕ\����ύX����B
��ʕ\���̃A�C�R�����ς�邾���ŁA�����𔻒f���Ă���킯�ł͂Ȃ��B

* `IT="HighlightNote"` �n�C���C�g�m�[�g
* `IT="StrikeOutTextEdit"` �u���e�L�X�g�̎�������

---

## �����ԂɏC��

�e�L�X�g�̕����Ԃɒ��߂�t����B

```xml
    <caret 
      color="#0000FF" 
      page="0" 
      fringe="0.810425,0.810425,0.810425,0.810425" 
      rect="144.145630,486.358154,156.081207,496.083344" >
      <contents-richtext>
        <body xmlns="http://www.w3.org/1999/xhtml"
              xmlns:xfa="http://www.xfa.org/schema/xfa-data/1.0/"
              xfa:APIVersion="Acrobat:21.7.0" xfa:spec="2.0.2">
          <p dir="ltr">
            <span dir="ltr" style="font-size:10.5pt;text-align:left;
            color:#000000;font-weight:normal;
            font-style:normal">�e�L�X�g�}��</span>
          </p>
        </body>
      </contents-richtext>
    </caret>
```

�}���e�L�X�g�́A`<caret ...>` �v�f�Ŏw�肷��B

`IT` �����Ŏ�ʕ\����ύX����B
��ʕ\���̃A�C�R�����ς�邾���ŁA�����𔻒f���Ă���킯�ł͂Ȃ��B

* `IT="Replace"` �u���e�L�X�g

`fringe` �����ɂ��A�C���͈̔͂��w�肷��

`content-richtext` �v�f�ɑ}���������ǉ�����B

---

## �e�L�X�g�̒u��

�e�L�X�g�u���́A�Ώۂ̃e�L�X�g�������� `<strikout>` �A�e�L�X�g��}�� `<caret>` ���邱�ƂőΉ�����B

```xml
    <strikeout 
      ...
      inreplyto="f68646b2-c171-4022-a033-f5731ed590a8" 
      IT="StrikeOutTextEdit" 
      replyType="group" 
      ... >
    </strikeout>
    <caret 
      ...
      IT="Replace" 
      ... >
      <contents-richtext>
        ...
      </contents-richtext>
    </caret>
```
