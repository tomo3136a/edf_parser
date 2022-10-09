# XFDF�t�@�C���t�H�[�}�b�g(�}�`)

`<annots>` �̎q�v�f�Ƃ��Đ}�`�v�f��z�u����B

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
        <annots>
            ...
        </annots>
        ...
    </xfdf>
```

��Ȑ}�`�v�f�ɂ͎��̎�ނ�����B

* ���E���� `<line>`
* �l�p�` `<square>`
* �~�E�ȉ~ `<circle>`
* ���p�` `<polygon>`
* �܂�� `<polyline>`
* ���R�Ȑ� `<ink>`

�e�}�`�v�f�̎q�v�f�� `<contents-richtext>` �v�f�܂��� `<contents>` �v�f��z���邱�Ƃɂ��A���߂̐�����t���邱�Ƃ��ł���B

---

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

---

## ���E����

���ɕ`���Ȑ��́A `<line ...>` �v�f���g�p����B

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

���̌`��F

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

---

## �l�p�`

�l�p�`�́A `<square ...>` �v�f���g�p����B

```xml
    <square 
        color="#E52237" 
        page="0" 
        fringe="0.500000,0.500000,0.500000,0.500000" 
        rect="346.694763,238.014526,400.188385,279.535950" >
    </square>
```

---

## �~�E�ȉ~

�~�`�́A `<circle ...>` �v�f�����g�p����B

```xml
    <circle 
        color="#E52237" 
        page="0" 
        fringe="0.500000,0.500000,0.500000,0.500000" 
        rect="447.998260,225.121338,503.333771,266.642761" >
    </circle>
```

---

## ���p�`

���p�`�́A `<polygon ...>`  �v�f���g�p����B  
`<polygon>` �̎q�v�f `<vertices>` �ɒ��_�̍��W����ׂ�B

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

---

## �܂��

�܂���́A `<polyline ...>`  �v�f���g�p����B  
`<polyline>` �̎q�v�f `<vertices>` �ɒ��_�̍��W����ׂ�B

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

---

## ���R�Ȑ�

���R�ɕ`���Ȑ��́A `<ink ...>` �v�f���g�p����B  
`<ink ...>` �v�f�̎q�v�f `<inkList>` ��z����B  
`<inkList>` �v�f�̎q�v�f `<gesture>` �ɋȐ��̒ʉߓ_����ׂ�B  
`<gesture>` �v�f�͕������ׂĕ����̐�����ɂ܂Ƃ߂邱�Ƃ��ł���B

```xml
    <ink 
        color="#E52237" 
        page="0" 
        rect="120.564209,336.055206,198.081390,405.942902" >
        <inklist>
            <gesture>
                121.564209,339.818024;
                122.485153,341.659912;
                124.327042,344.422729;
                ...
                197.081390,337.055206
            </gesture>
            ...
        </inklist>
    </ink>
```

---
