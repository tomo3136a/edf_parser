# XFDF�t�@�C���t�H�[�}�b�g(fields)

`<fields>` �Ƀt�H�[���f�[�^��z�u����B

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

�t�H�[���f�[�^�ɂ́A�P���t�H�[���f�[�^�ƊK�w�\���t�H�[���f�[�^�̓��ނ�����B

* �P���t�H�[���f�[�^        �`���F {���O}={�l}
* �K�w�\���t�H�[���f�[�^    �`���F {�O���[�v��}.{���O}={�l}

---

## �P���t�H�[���f�[�^

�t�H�[���f�[�^�́A`<field ...>`�v�f��`name`�������L�[�Ƃ���`<value>`�v�f�ɒl���w�肷��B  
�t�H�[���f�[�^�͕����̃t�B�[���h�������Ƃ��o����B

  ��F  
    Name=Adobe Systems, Inc.  
    Street=345 Park Ave.

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

---

## �K�w�\��

`<field ...>`�v�f�͓���q�ɂ��邱�ƂŊK�w�\�������A�O���[�s���O�ł���B  

  ��F  
    Address.Name=Adobe Systems, Inc.  
    Address.Street=345 Park Ave.

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

---

## �t�B�[���h�̒l

* `<value>` �v�f
* `<value-ritchtext>` �v�f

�t�B�[���h�̒l�Ƃ��� `<value>` �v�f���g�p����ꍇ�́A�P���ȃe�L�X�g�f�[�^�Ƃ��Ĉ����B  
`<value>` �v�f�̑���� `<value-ritchtext>` �v�f���g�p�����ꍇ�A���b�`�e�L�X�g���g�p�ł���B  
���b�`�e�L�X�g�� xhtml �̃T�u�Z�b�g�Ŏw�肵�A�t�H���g�̎w��Ȃǃe�L�X�g�̕\�����w��ł���B  
�������A���b�`�e�L�X�g�Ƃ��Ĉ������P���ȃe�L�X�g�f�[�^�Ƃ��Ĉ������́A�l���������ɂ��B

  ��F  xhtml �`���̕���( 
            <span style="font-size:10.0pt"><i>���b�`</i>�e�L�X�g</span>
        )�̏ꍇ

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

xml ���O��Ԃ́A`http://www.w3.org/1999/xhtml` ���w�肵�Axhtml �̃T�u�Z�b�g���g�p���邱�Ƃ��o����B  
xml ���O��Ԃ́A`http://www.xfa.org/schema/xfa-data/1.0/` ���w�肵�A `xfa:APIVersion` �� `xfa:spec` ���g�p���邱�Ƃ��o����B  
xml ���O��ԁAxml ���O��ԁA�����`xfa:APIVersion` �� `xfa:spec` �̒l�Ƃ̑g�ݍ��킹�͒�^�ł���B���̒�`�ȊO�̏ꍇ�́A�Ӑ}�����\�����o���Ȃ��\��������B
