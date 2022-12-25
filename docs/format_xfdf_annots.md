# XFDF�t�@�C���t�H�[�}�b�g(�R�����g)

`<annots>` �̎q�v�f�Ƃ��ăR�����g�v�f��z�u����B

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
        <annots>
            ...
        </annots>
        ...
    </xfdf>
```

��ȃR�����g�v�f�ɂ͎��̎�ނ�����B

* [�e�L�X�g�̍Z��](format_xfdf_proof.md)
  * �e�L�X�g�ɏC��
    * �n�C���C�g�\�� `<highlight>`
    * ���� `<underline>`
    * �g���� `<squiggly>`
    * �������� `<strikeout>`
  * �����ԂɏC��
    * �}���e�L�X�g `<caret>`
* [�e�L�X�g](format_xfdf_text.md)
  * �m�[�g���� `<text>`
  * �e�L�X�g���߁E�e�L�X�g�{�b�N�X�E�����o�����t���e�L�X�g�{�b�N�X `<freetext>`
* [�`��c�[��](format_xfdf_figure.md)
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

## �R�����g�v�f�̋��ʑ���

�R�����g�v�f�́A���̎q�v�f�܂��͑����������Ƃ��ł���B

* ���ʏ�񑮐�
  * `title` ����(�ȗ���)
  * `subject` ����(�ȗ���)
* ���t����
  * `date` ����
  * `createdate` ����
* ���v���C����
  * `name` ����
  * `inreplyto` ����
  * `replyType` ����
* �|�b�v�A�b�v�m�[�g�v�f
* `name` ���O����

---

## `title` ����

�R�����g�̍쐬��(���L�L����)���w�肷��B

## `subject` ����

������������킵�����A�v���p�e�B�̃^�C�g�����́A`subject` �����Ɏw�肷��B  
�ʏ�́A�R�����g�̎�ނ��������B���Ɏg�p����̂��͕s���B

---

## `date` ����

�R�����g�̕ύX���t���w�肷��B  
`2021�N12��19�� 19��16��24�b +09:00`�́A`"D:20211219191624+09'00'"` �ŕ\���B


## `createdate` ����

�R�����g�̍쐬���}�Ƃ��w�肷��B  
`2021�N12��19�� 19��16��24�b +09:00`�́A`"D:20211219191624+09'00'"` �ŕ\���B

---

## `name` ����

�R�����g�v�f�� `inreplyto` �����Ŏw�肵�����O�̃R�����g�v�f�ւ̃��v���C�Ƃ��Ĉ����B  
��ӂȕ�������w�肷��B��ʓI�ɂ� uuid �o�[�W����4�A�o���A���g1 ���g�p�����B

uuid�F `RRRRRRRR-RRRR-4RRR-rRRR-RRRRRRRRRRRR`

* R:�����̒l  
* r:����2�r�b�g�������X�Ƃ���8,9,A,B�̂ǂꂩ

```xml
    <text 
        name="65ba4fde-e993-45ab-8176-1f60177b948a" >
        <contents-richtext>
            �e�L�X�g
        </contents-richtext>
    </text>
```

## `inreplyto` ����/`replyType` ����

�R�����g�v�f�� `inreplyto` �����Ŏw�肵�����O(`name`����)�̃R�����g�v�f�ւ̃��v���C�Ƃ��Ĉ����B  
`replyType` �����ŁA�ԐM(�ȗ�)���O���[�v(`group`)�����w�肷��B

* `replyType`
  * �ȗ����͕ԐM
  * `replyType="group"` �O���[�v��(�����̒��ߗv�f��1�Ƃ��Ĉ����w��)

### �ԐM

```mermaid
graph RL;
A[�ԐM�e�L�X�g2]-->|inreplyto|B;
B[�ԐM�e�L�X�g1]-->|inreplyto|C[�R�����g];
```

```xml
    <text 
        name="65ba4fde-e993-45ab-8176-1f60177b948a" >
        <contents-richtext>
            �R�����g
        </contents-richtext>
    </text>

    <text 
        inreplyto="65ba4fde-e993-45ab-8176-1f60177b948a" 
        name="d3a51b32-240c-444a-94a9-ac97ccb23471" >
        <contents-richtext>
            �ԐM�e�L�X�g�P
        </contents-richtext>
    </text>

    <text 
        inreplyto="d3a51b32-240c-444a-94a9-ac97ccb23471" 
        name="..." >
        <contents-richtext>
            �ԐM�e�L�X�g�Q
        </contents-richtext>
    </text>
    ...
```

### �O���[�v

�����̃R�����g���O���[�v�����A1�̃R�����g�Ƃ��Ĉ����B

```mermaid
graph BT;
B[�����o2]-->|inreplyto|A[�O���[�v<�����o1>];
C[�����o3]-->|inreplyto|A;
D[�����o4]-->|inreplyto|A;
```

```xml
        <square name="�����o1"  .../>
        <circle inreplyto="�����o1"
                name="�����o2" replyType="group" .../>
        <circle inreplyto="�����o1"
                name="�����o3" replyType="group".../>
        <circle inreplyto="�����o1"
                name="�����o4" replyType="group" .../>

```

---

## popup

* �|�b�v�A�b�v�m�[�g `<popup>`

---

## �|�b�v�A�b�v�m�[�g

* �|�b�v�A�b�v�m�[�g `<popup>`

PDF�r���[�A�́A�R�����g�v�f��I�������ꍇ�A�R�����g���e���|�b�v�A�b�v���ĕ\������B  
�R�����g�v�f�̓|�b�v�A�b�v�m�[�g�������Ƃ��ł���B  
�|�b�v�A�b�v�m�[�g�́A�|�b�v�A�b�v�\���ʒu���w�肷��B(�ȗ���)

�e�R�����g�v�f�̎q�v�f�Ƃ��� `<popup ...>` ��z�u����B

* `flags` �t���O(��������ꍇ�̓J���}��؂�)
  * `print`
  * `nozoom`
  * `norotate`
* `open` �\�����(`no`:�v������ƊJ���A`yes`:�ŏ�����J���Ă���)
* `page` �\������y�[�W
* `rect` �\������͈�

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

## �R���e���c

�R���e���c�̓e�L�X�g���͂����B�R���e���c��2��ނ���B

* �R���e���c `contents`  
  �����f�[�^�͎g�p�ړI�ɂ���ĈقȂ�B  
  �e�L�X�g���ړI�Ȃ�΁A���ʂȏC������Ă��Ȃ���������w�肷��B
* ���b�`�e�L�X�g�̃R���e���c `contents-richtext`  
  �t�H���g�w���A�����F�w��ȂǊȒP�ȕ\�����s�����e�L�X�g���w�肷��B  
  ��{�I�ɂ́AXHTML �̃T�u�Z�b�g���g�p����B

---

## ���̂ق�

* [���W�ϊ�](format_xfdf_trans.md)

