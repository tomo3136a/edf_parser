# XFDF�t�@�C���t�H�[�}�b�g(����)

`<annots>` �̎q�v�f�Ƃ��Ē��ߗv�f��z�u����B

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
        <annots>
            ...
        </annots>
        ...
    </xfdf>
```

��Ȓ��ߗv�f�ɂ͎��̎�ނ�����B

* [�e�L�X�g�̍Z��](format_xfdf_proof.md)
  * �e�L�X�g�ɏC��
    * �n�C���C�g `<highlight>`
    * ���� `<underline>`
    * �g���� `<squiggly>`
    * �������� `<strikeout>`
  * �����ԂɏC��
    * �}���e�L�X�g `<caret>`
* [�e�L�X�g](format_xfdf_text.md)
  * �m�[�g���� `<text>`
  * �e�L�X�g���߁E�e�L�X�g�{�b�N�X�E�����o�����t���e�L�X�g�{�b�N�X `<freetext>`
* [�}�`](format_xfdf_figure.md)
  * ���E���� `<line>`
  * �l�p�` `<square>`
  * �~�E�ȉ~ `<circle>`
  * ���p�` `<polygon>`
  * �܂�� `<polyline>`
  * ���R�Ȑ� `<ink>`
* [�X�^���v](format_xfdf_stamp.md) `<stamp>`
* [���ߍ��݃I�u�W�F�N�g](format_xfdf_embd.md)
  * �Y�t�t�@�C�� `<fileattachiment>`
  * �T�E���h�f�[�^ `<sound>`
* ���̑�  
  `link`, `redact`,  
  `projection`, `movie`, `widget`, `screen`,  
  `printmark`, `trapnet`, `richmedia`, `3d`, `watermark`

---

## �|�b�v�A�b�v�m�[�g

* �|�b�v�A�b�v�m�[�g `<popup>`

���ߗv�f�̓|�b�v�A�b�v�m�[�g�������Ƃ��ł���B
�e���ߗv�f�̎q�v�f�Ƃ��� `<popup ...>` ��z�u����B

* `flags` �t���O(��������ꍇ�̓J���}��؂�)
  * `print`
  * `nozoom`
  * `norotate`
* `open` �\�����(`no`:�v������ƊJ���A`yes`:�ŏ�����J���Ă���)
* `page` �\������y�[�W
* `rect` �\������͈�

---

## ���v���C

���ߗv�f��`inreplyto`�����Ŏw�肵�����O�̒��ߗv�f�ւ̃��v���C�Ƃ��Ĉ����B

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
  * `replyType="group"` �O���[�v��(�����̒��ߗv�f��1�Ƃ��Ĉ����w��)

---

## ���

���ߗv�f�͏�Ԃ�\���o����B��Ƀ��v���C�@�\�ƕ��p����B  
`statemodel` �����ŏ�ԃ��f�����w�肵�A`state`�����ɏ�Ԃ��w�肷��B

### �X�e�[�^�X�@�\

`Review`���f�����g�p����

* `statemodel="Review"`
  * `state="None"` �Ȃ�
  * `state="Accepted"` ���F
  * `state="Cancelled"` �L�����Z��
  * `state="Completed"` ����
  * `state="Rejected"` �p��

### �`�F�b�N�}�[�N�@�\

`Marked`���f�����g�p����

* `statemodel="Marked"`
  * `state="Marked"` �}�[�N�ݒ�
  * `state="Unmarked"` �}�[�N����

---

## ���t

`date`������`createdate`�����́A���t���w�肷��B  
`2021�N12��19�� 19��16��24�b +09:00`�́A`"D:20211219191624+09'00'"` �ŕ\���B

---

## �R���e���c

�R���e���c�̓e�L�X�g���͂����B�R���e���c��2��ނ���B

* �R���e���c `contents`  
  �����f�[�^�͎g�p�ړI�ɂ���ĈقȂ�B  
  �e�L�X�g���ړI�Ȃ�΁A���ʂȏC������Ă��Ȃ���������w�肷��B
* ���b�`�e�L�X�g�̃R���e���c `contents-richtext`  
  �t�H���g�w���A�����F�w��ȂǊȒP�ȕ\�����s�����e�L�X�g���w�肷��B  
  ��{�I�ɂ́AXHTML �̃T�u�Z�b�g���g�p����B
