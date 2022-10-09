# XFDF�t�@�C���t�H�[�}�b�g

## �T�v

XFDF �t�@�C���́A FDF �t�@�C���� XML �t�@�C���łł���B
�t�H�[���f�[�^�ƒ��߂�ۑ�����B

## XFDF�̎d�l

XFDF�̌`���́A�uISO 19444-1�v�ɏ�������B

�� �g�p����PDF�r���[�A�A�o�[�W�������ɂ��[����](format_xfdf_limit.md)������B

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

---

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

* ���[�g�́A`<xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">`�Ƃ���
* `<f href="...">` ��pdf�t�@�C���ւ̃����N�B�����Ă��悢�B
* `<ids original="..." modified="...">` ��pdf�t�@�C���ւ̃����N���B�����Ă��悢�B

---

## �q�v�f

���[�g`<xfdf ...>`�̎q�v�f�Ƃ��ăt�H�[���f�[�^�⒍�߂�z�u����B

* `<fields>` [�t�H�[���f�[�^](format_xfdf_fields.md)
* `<annots>` [����](format_xfdf_annots.md)
  * [�e�L�X�g�̍Z��](format_xfdf_proof.md)
  * [�e�L�X�g](format_xfdf_text.md)
  * [�}�`](format_xfdf_figure.md)
  * [�X�^���v](format_xfdf_stamp.md)
  * [���ߍ��݃I�u�W�F�N�g](format_xfdf_embd.md)

---

## ���̂ق�

* [���W�ϊ�](format_xfdf_trans.md)

---
