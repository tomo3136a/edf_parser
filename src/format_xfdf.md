# XFDF�t�@�C���t�H�[�}�b�g

## �g���q

`.xfdf`

## root

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
        <annots>
            <square width="9.000000" color="#E52237" opacity="0.494995"
                creationdate="D:20211219185715+09'00'" flags="print" interior-color="#FFAABF" 
                date="D:20211219191624+09'00'" name="f4873cca-4d0f-47fb-8be9-ded59e5dabaa"
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

* `<f href="...">` ����� `<ids original="..." modified="...">` ����pdf�t�@�C���ւ̃����N���B
  �����Ă��悢
* root�́A`<xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">`�Ƃ���
* �R�����g�u���b�N��`<annots>`���ɔz�u����B�R�����g�u���b�N�ɂ͎��̎�ނ�����B
  * �n�C���C�g
  * �l�p�`
  * ���̂ق����낢��
* �R�����g�u���b�N�̋��ʑ���
  * `width` �g�̕�(�P�ʂ̓|�C���g) ���ȗ�����1�|�C���g��
  * `color` �g�̐F(#rrggbb) ���ȗ����͘g�Ȃ�
  * `opacity` �����x(0�`1,�����_�\�L) ���ȗ����͕s����
  * `inter-color` �̈���̐F(#rrggbb) ���ȗ����͗̈�F�Ȃ�
  * `date`,`creationdate` ���t(�ȗ���)
    ��`date`���ȗ�����ƍX�V����`�s��`�\���ɂȂ�̂ŏȗ����Ȃ��ق����ǂ�
  * `flags` �t���O(��������ꍇ�̓J���}��؂�)
    * `print` ����Ώ�
    * `nozoom`
    * `norotate`
  * `name` �u���b�N�̖��O(�ȗ���)
  * `page` �\������y�[�W
  * `rect` �\������͈�
  * `fringe` �t�����W(�ȗ���) �ʏ�͊e�� `width` �̗̈敪�݂���
  * `subject` �u���b�N�̃T�u�W�F�N�g(�ȗ���)
  * `title` �^�C�g���E�쐬�Җ�(�ȗ���)
* �n�C���C�g�́A`<highlight ...>` �Ŏw�肷��B
* �l�p�`��`<square ...>`�Ŏw�肷��B
* �e�u���b�N�ɂ̓|�b�v�A�b�v�m�[�g��݂��邱�Ƃ��ł���B `<popup ...>`
  * `flags` �t���O(��������ꍇ�̓J���}��؂�)
    * `print`
    * `nozoom`
    * `norotate`
  * `open` �\�����(`no`:�v������ƊJ���A`yes`:�ŏ�����J���Ă���)
  * `page` �\������y�[�W
  * `rect` �\������͈�
