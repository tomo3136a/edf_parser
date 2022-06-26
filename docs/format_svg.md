# SVG�t�@�C���t�H�[�}�b�g

## �T�v

SVG �t�@�C���́A �x�N�^�摜�� XML �t�@�C���ł���B

�d�l�͎����Q�ƁF  
https://triple-underscore.github.io/SVG11/index.html

## �g���q

`.svg`

## example

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <svg style="background: #444" viewBox="120,30,1290,860" 
        version="1.1" 
        xmlns="http://www.w3.org/2000/svg"
        xmlns:xlink="http://www.w3.org/1999/xlink">
        <g>
            <rect fill="#fff" x="130" y="40" width="1270" height="840" />
            <g stroke="black" stroke-width="1" fill="none">
                <text fill="rgb(0,0,0)" stroke-width="0" 
                    font-weight="bold" font-size="7" font-family="Arial" 
                    dominant-baseline="central" text-anchor="start" 
                    transform="translate(1368,789)">0</text>
                <circle r="1" fill="#0" stroke="green" stroke-width="1"
                    cx="1368" cy="789" />
            </g>
            <path fill="none" d="M 50,-110 50,120" />
        </g>
    </svg>
```

## ���[�g

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <svg version="1.1"
        xmlns="http://www.w3.org/2000/svg"
        xmlns:xlink="http://www.w3.org/1999/xlink">
        ...
    </svg>
```

* `<?xml version="1.0" encoding="UTF-8"?>` �͂����Ă��Ȃ��Ă������B
* root�́A`<svg xmlns="http://www.w3.org/2000/svg" version="1.1"/>`�Ƃ���
* `xlink`���g���̂�`xmlns:xlink="http://www.w3.org/1999/xlink"`���錾����B

## ���W

���W�́A��������_�Ƃ��đ��ی��z�u����B

�P�ʂ̓|�C���g(pt) 96dpi, 1inch=25.4mm, 1inch=96pt  
�� pt(x)=x*96/25.4

96dpi = 72dpi * 4/3

## �}�`

�}�`�͂��낢�날��

* ���� `<line x1= y1= x2= y2= .../>`
  * rx=,ry= �p��
* �܂�� `<polyline points= .../>`
* �l�p `<rect x= y= width= height= .../>`
* ���p�` `<polygon points= .../>`
* �~ `<circle cx= cy= r= .../>`
* �ȉ~ `<ellipse cx= cy= rx= ry= .../>`
* �p�X `<path d= .../>`
* �e�L�X�g `<text x= y= ...>...</text>`
  * ���� `font-family=`
  * �E�F�C�g `font-weight=`
  * �T�C�Y `font-size=`
  * �X�^�C�� `font-style=`
  * ���� `text-decoration=`
  * �񂹈ʒu `text-anchor=`
  * �����Ԋu `letter-spacing=`
  * �P��Ԋu `word-spacing=`
* �C���[�W `<image x= y= width= height= xlink:href= .../>`
  * �A�X�y�N�g�� `preserveAspectRatio`

## ���̑���

* ���F `stroke=`
  * `none` �`��Ȃ�
* ���� `stroke-width=`
* ���[�`�� `stroke-linecap=`
  * �f�t�H���g `butt`
  * �� `round`
  * �l�p `square`
* ���ڑ����`�� `stroke-linejoin=`
  * �낪�� `miter`
  * �� `round`
  * �ʎ�� `bevel`
* ���ڑ����`��臒l `stroke-miterlimit=`
* �j�� `stroke-dasharray=`
* �����x `stroke-opacity=`

## �}�[�J�[

`<marker id=>...</marker>`

* �n�_ `<line marker-start=>...</line>`
* �I�_ `<line marker-end=>...</line>`
* ���Ԃ̒��_ `<line marker-mid=>...</line>`

## �ʂ̑���

* �h��F `fill=`
  * �h��Ȃ� `none`
* �h�蓧���x `opacity=`

## �p�^�[���E�O���f�B�F�[�V����

## �e�L�X�g

�󔒕����̈���

���̂܂܂����� `xml:space="preserve"`

## �e�L�X�g�̋O��

```xml
  <text>
    <textPath xlink:href="#...">
      ...
    </textPath>
  </text>
```

## �e�L�X�g�̃����N����

`<text pointer-events="none">...</text>`

## �O���[�v��

`<g>`�ŃO���[�v�����đ������܂Ƃ߂Ē�`����  
`<use>`�Ő}�`���g�p����

```xml
  <g id="aaa">...</g>

  <use x=100 y=200 xlink:href="#aaa" />
```

## �V���{��

```xml
  <symbol id="aaa" ...>
    ...
  </symbol>
```

* �\���͈� `viewbox=`
* �A�X�y�N�g�� `preserveAspectRatio`

## ��`

��\���̐}�`���܂Ƃ߂Ē�`����

`<defs>...</defs>`

## �}�`�ό`

* �}�`�ό` `transform=`
  * ���s�ړ� `translate(tx,ty)`
  * �g��k�� `scale(sx,sy)`
  * ��] `rotate(angle,cx,cy)`
  * ���ւ���f `skewX(angle)`
  * �c�ւ���f `skewY(angle)`
  * �A�t�@�C���ϊ� `matrix(a,b,c,d,e,f)`
