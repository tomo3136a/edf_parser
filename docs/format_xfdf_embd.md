# XFDF�t�@�C���t�H�[�}�b�g(���ߍ��݃I�u�W�F�N�g)

`<annots>` �̎q�v�f�Ƃ��ăI�u�W�F�N�g�v�f��z�u����B

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
        <annots>
          <fileattachment .../> <!-- �Y�t�t�@�C�� -->
          <sound .../>          <!-- �T�E���h�f�[�^ -->
            ...
        </annots>
        ...
    </xfdf>
```

�I�u�W�F�N�g�v�f�ɂ͎��̎�ނ�����B

* �Y�t�t�@�C�� `<fileattachment>`
* �T�E���h�f�[�^ `<sound>`

---

## �Y�t�t�@�C��

�Y�t�t�@�C���́A�t�@�C���A�C�R����z�u���A�A�C�R����I������ƓY�t�t�@�C�����擾�ł���B  
�Y�t�t�@�C���́A `<fileattachment ...>` �v�f���g�p����B

```xml
    <fileattachment 
        color="#4055FF" 
        checksum="B7D08EB508BF8F1361DC8E72345AD4A6" 
        modification="D:20221002085649+09'00'" 
        size="605" 
        mimetype="text/plain" 
        file="list.txt" 
        name="45f67f6d-ab43-4ed9-804d-fdf3182fdbaf" 
        icon="Paperclip" 
        page="0" 
        rect="115.277695,679.661560,122.277695,696.661560" >
        <contents-richtext>
            <body xmlns="http://www.w3.org/1999/xhtml" 
                xmlns:xfa="http://www.xfa.org/schema/xfa-data/1.0/" 
                xfa:APIVersion="Acrobat:22.2.0" xfa:spec="2.0.2">
                <p>list.txt</p>
            </body>
        </contents-richtext>
        <data MODE="raw" encoding="hex" length="226" filter="FlateDecode">
            488974913D0EC2300C85E756EA1D72800A25717F60AED811
            034BD5898BD06660AA5409A9576163421C8289A3D0E716D2...
            02BFBEB4EF5CCAA12AF747256528BAA8C22E6864244C6D0E...
            ...
        </data>
    </fileattachment>
```

* `icon` �A�C�R�����w�肷��
  * �ȗ��� �Y�t
  * `icon="Paperclip"` �N���b�v
  * `icon="Graph"` �O���t
  * `icon=""` �Y�t
  * `icon="Tag"` �^�O
* `rect` �A�C�R���̕\���̈���w�肷��
* `checksum` �f�[�^�̃`�F�b�N�T��
* `size` �f�[�^�̃T�C�Y
* `mimetype` MIME-Type ���w��
* `file` �t�@�C����
* �f�[�^�� `<data>` �v�f�Ɏw�肷��B
* ���߃e�L�X�g�� `<contents-richtext>` �v�f�A�܂��� `<contents>` �v�f�Ɏw�肷��

---

## �T�E���h�f�[�^

�T�E���h�f�[�^�A�A�C�R����z�u���A�A�C�R����I������ƃT�E���h���Đ��ł���B  
�T�E���h�f�[�^�́A `<sound ...>` �v�f���g�p����B

```xml
    <sound 
        color="#4055FF" 
        name="61e9cfdf-b7c6-4bc9-abe5-fa4befd40286" 
        page="0" 
        rect="138.502136,682.083862,158.502136,697.083862" 
        bits="16" 
        encoding="signed" 
        rate="8192" >
        <contents-richtext>
            <body xmlns="http://www.w3.org/1999/xhtml" 
                xmlns:xfa="http://www.xfa.org/schema/xfa-data/1.0/" 
                xfa:APIVersion="Acrobat:22.2.0" xfa:spec="2.0.2">
                <p>�T�E���h�N���b�v (62 KB)</p>
            </body>
        </contents-richtext>
        <data MODE="raw" encoding="hex" length="64436" filter="FlateDecode">
            48890C942F70E20A02C60384BF0934B440534AFBD26DFA96
            9DE5BDE5EE987B15BD196E068140202210880804A2028140...
            CC3C04338F79CBBDE576DB2D6DB3348514420934402801AE...
            E0B7F5797EA8EA095C9A8FDE38EFE867102C1ACB4AA7C8CE...
            ...
        </data>
    </sound>
```

* `icon` �A�C�R�����w�肷��
  * �ȗ��� �T�E���h
  * `icon=""` �T�E���h
  * `icon="Mic"` �}�C�N
  * `icon="Ear"` ��
* `rect` �A�C�R���̕\���̈���w�肷��
* `bits` �T���v�����O�f�[�^�̃r�b�g��
* `encoding` �G���R�[�h���@
* `rate` �T���v�����O���[�g
* �f�[�^�� `<data>` �v�f�Ɏw�肷��B
* ���߃e�L�X�g�� `<contents-richtext>` �v�f�A�܂��� `<contents>` �v�f�Ɏw�肷��
