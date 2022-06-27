# EDIF�t�@�C���t�H�[�}�b�g

EDIF �t�@�C���́A��H�}�̌����t�H�[�}�b�g�ł���B  
EDIF �̃o�[�W�����́A`2.0.0`��`3.0.0`�����邪�A�e�o�[�W�����Ԃ̌݊����͍����Ȃ��B  
��H�}CAD��`2.0.0`����ʓI�ł���A`3.0.0`�͎g���Ă��Ȃ��̂�����ł���B  
���̂��߁A���̃h�L�������g�́A`2.0.0`��ΏۂƂ���B

## root of edif

�ŏ�ʗv�f�́A`edif`�ł���B  
`edif`�v�f�� �A`edifVersion` , `edifLevel` , `keywordMap` �̑����v�f������B��^�p�^�[���ł���A���̒l�͑ΏۊO�Ƃ���B
`status`�����́A�d�v�ł͂Ȃ����A�c�[���̊Ǘ������܂ށB

`edif`�v�f�́A�����v�f�̑��� `library`, `external`, `design` �̉��ʗv�f���܂ނ��Ƃ��ł���B

```lisp
    (edif
        [nameDef]
        (edifVersion 2 0 0)
        (edifLevel 1)
        (keywordMap (keywordLevel 0))
        (status ...)
        (external [nameDef] ...)...     # �O�����C�u�����ւ̎Q��
        (library [nameDef]              # �������C�u�����̒�`
            (cell [nameDef]             # cell �̒�`
                (cellType TIE/RIPPER/GENERIC)
                (status ...)
                (viewMap ...)
                (view [nameDef]         # view �̒�`
                    (viewType MASKLAYOUT/PCBLAYOUT/NETLIST/
                              SCHEMATIC/SYMBOLIC/BEHAVIOR/
                              LOGICMODEL/DOCUMENT/GRAPHIC/
                              STRANGER)
                    (status ...)
                    (interface ...)     # interface �̒�`
                    (contents ...)      # contents �̒�`
                    )...
                    (property...)...
                )...
            )...
        )...
        (design [nameDef] 
            (cellRef [nameRef] (libraryRef [nameRef]))
            (status...)...
            (property...)...
        )
    )
```

`library` �� `external` �́A������ `cell` �����C�u�����Ƃ��Ă܂Ƃ߂����̂ł���B
`external` �͊O���Q�Ƃ���B  
`cell` �͕��i�ɑ������A���i�̕\�����@�Ƃ��ĕ����� `view` �������Ƃ��o����B  
`view` �ɂ� `interface` �� `contents` �̉��ʗv�f������B  
`interface` �̓C���^�[�t�F�[�X���`���A `contents` �͓��e���`����B  
`design` �́Aedif �t�@�C���̃g�b�v�f�U�C�� `cell` ���Q�Ƃ��w�肷��B

** ���̑��� comment/userData �v�f���e���ɓ������B�����ł͖������邱�ƂƂ���B

---

## sutatus

`edif`, `external`, `library`, `cell`, `view`, `design` �v�f�̑������`����B

```lisp
    (status
        (written
            (timeStamp 0 0 0 0 0 0)     # �쐬��
            (author "")...              # �쐬��
            (program ""                 # �����c�[����
                (version "")?)...       # �c�[���o�[�W����
            (dataOrigin ""              # ���f�[�^�̍쐬�c�[����
                (version "")?)...       # ���f�[�^�̃o�[�W����
            (property...)...
        )
    )
```

---

## nameDef / nameRef

��`�Ɏg�p����ID��  
`edif`, `external`, `library`, `cell`, `view`, `design` �v�f�Ȃǂ�ID�����`����B  
�Q�ƌĂяo���̌Ăяo����Ɏg�p���A��{�I�ɂ͈�ӂ̖��O�Ƃ���B

���O�̒�`���@�ɂ͂������p�^�[��������B

```lisp
    [ident]                         # ID�����`
    (name [ident] (display ...))    # ID�����`, �\�����@�w��
    (rename                         # ID�����`, �ʖ����`
        [ident]/(name [ident] ...)  # ID��,�ʖ����ɕ\�����@�w��\
        "str"/(strringDisplay ...)
    )
```

ID���́A�g�p�\������ɐ���������B���̂��߁A��H�̖��̂Ƃ͈قȂ�ꍇ������B  
���̂��߁A�ʖ� "str" ��t���邱�Ƃ��ł���B
�܂��AID������ѕʖ��͂�\�����@���w��ł���B

## �Q��

`nameRef` ���w�肵�đ��̊K�w�ɂ���f�[�^���Q�Ƃ���B

### library �Q��

```lisp
    (libraryRef name)
```

### cell �Q��

use : `design`

���C�u�������� `cell` ���Q�Ƃ���B

```lisp
    (cellRef name)
    (cellRef name (libraryRef name))
```

### view �Q��

use : `instance`, `site`, `viewList`

���C�u�������� `cell` ���� `view` ���Q�Ƃ���B

```lisp
    (viewRef name)
    (viewRef name (cellRef name))
    (viewRef name (cellRef name (libraryRef name)))
```

### figureGroup �Q��

use : `includeFigureGroup`, `intersection`, `inverse`,
      `overSize`, `union`, `difference`, `figureGroupObject`

���C�u�������� `figureGroup` ���Q�Ƃ���B

```lisp
    (figureGroupRef name)
    (figureGroupRef name (libraryRef name))
```

### globalPort �Q��

use : `joined`

�|�[�g�ւ̎Q�Ƃ�����B

```lisp
    (globalPortRef name)
```

### port �Q��

use : `portGroup`, `portInstance`, `portList`, `portMap`,
      `steady`, `tableDefault`, `weekJoined`, `change`,
      `entry`, `event`, `follow`, `logicAssign`,
      `loginInput`, `logicOutput`, `maintain`, `match`,
      `mustJoin`, `nonPermut`, `Permutable`, `portBackAnotate`

`view` �� `port` �ւ̎Q�Ƃ�����B  
`view` �� `instance` �� `port` �ւ̎Q�Ƃ�����B

```lisp
    (portRef name)
    (portRef name (portRef name (...)))
    (portRef name (viewRef name))
    (portRef name (viewRef name (cellRef name)))
    (portRef name (viewRef name (cellRef name (libraryRef name))))
    (portRef name (instanceRef name))
    (portRef name (instanceRef name (viewRef name)))
    (portRef name (instanceRef name (viewRef name (cellRef name))))
    (portRef name (instanceRef name (viewRef name (cellRef name (libraryRef name)))))
```

### net �Q��

use : `netGroup`, `netMap`, `event`, `netBackAnnotate`

`view` �� `net` �ւ̎Q�Ƃ�����B  
`view` �� `instance` �� `net` �ւ̎Q�Ƃ�����B

```lisp
    (netRef name)
    (netRef name (netRef name (...)))
    (netRef name (viewRef name))
    (netRef name (viewRef name (cellRef name)))
    (netRef name (viewRef name (cellRef name (libraryRef name))))
    (netRef name (instanceRef name))
    (netRef name (instanceRef name (viewRef name)))
    (netRef name (instanceRef name (viewRef name (cellRef name))))
    (netRef name (instanceRef name (viewRef name (cellRef name (libraryRef name)))))
```

### logic �Q��

�V�~�����[�V�����p�Q�ƁB

```lisp
    (logicRef name)
    (logicRef name (libraryRef name))
```

---

## design

�g�b�v�f�U�C���� `cell` �ւ̎Q�Ƃ��w�肷��B

```lisp
    (design [nameDef] 
        (cellRef [nameRef]
            (libraryRef [nameRef])))
```

---

## library / external

�������C�u����(`library`)��O�����C�u����(`external`)���`����B  
`edif` �́A�����̃��C�u�����������Ƃ��ł��A���C�u�����͕�����`cell`�������Ƃ��ł���B  
`cell` �́A������ `view` �������Ƃ��ł���B
`technology` �Ń��C�u�����̋��ʂ̊�b�����`����B  

```lisp
    (library [nameDef]                  # �������C�u�����̒�`
        (technology ...)                # �݌v���
        (cell [nameDef] ...)...         # cell �̒�`
    )...
```

## technology

�݌v����`

�قȂ�c�[���ɂ���Đ������ꂽ�����̃��C�u�����𗘗p����ꍇ�Ɋ�����킹�Ɏg�p����B  
�ʏ�͓����ݒ�ɂ��邽�ߕϊ������͏Ȃ��ėǂ��B

```lisp
    (technology
        (numberDefinition               # �ݒl
            (scale                      # �X�P�[���̒�`
                0/(e 0 0)
                0/(e 0 0)
                (unit ...))...
            (gridMap                    # �O���b�h�̒�`
                0/(e 0 0) 
                0/(e 0 0))...
        )
        (figureGroup ...)...            # �}�`�����ݒ�
        (fabricate ...)...              # ���C���ɑΉ������}�`�����̑Ή��ݒ�
        (simulationInfo ...)...         # �V�~�����[�V�������
        (physicalDesignRule ...)...     # �����݌v���[�����
    )
```

## scale

```lisp
    (scale 1 (e 254 -6) (unit DISTANCE))
```

��) (e 254 -6) => 254*10^(6-6)=254 cm

�P�ʂ̎��

```lisp
    (unit DISTANCE/CAPACITANCE/CURRENT/RESISTANCE/TEMPERATURE/
          TIME/VOLTAGE/MASS/FREQUENCY/INDUCTANCE/ENERGY/POWER/
          CHARGE/CONDUCTANCE/FLUX/ANGLE)
```

## gridMap

```lisp
        (gridmap 1 1)
```

## figureGroup

`figureGroup` �́A�}�`�̋@�\��ʁB  
�F(`color`)�A�R�[�i�[�`��(`cornerType`)�A�[�_�`��(`endType`)�A������̍���(`textHeight`)�A
�p�X�̕�(`pathWidth`)�A�t�B���p�^�[��(`fillPattern`)�A�v���p�e�B(`property`)��
���ʂ����v�f������Z�߂�B  
`property` �ɂ́A`ETCFONTNAME` , `TEXTWIDTH` �Ȃǂ��邪�A�c�[���Ɉˑ�����B

�}�̐ݒ�𖼑O��t���Ē�`����B

```lisp
    (figureGroup [nameDef]
        (cornerType EXTEND/ROUND/TRUNCATE)      # �p�̌`��w�� (�L�΂��A�ۂ߂�A�؂�l�߂�)
        (endType EXTEND/ROUND/TRUNCATE)         # �n�_�E�I�_�̌`��w��
        (pathWidth 0)                           # ����
        (borderWidth 0)                         # �͂ݘg�̕�
        (color 0 0 0)                           # �F (�l�͐����l���X�P�[���l�A�e���͈̔͂�0-100?)
        (fillPattern 0 0 (boolean (true)))      # �h��X�^�C��
        (borderPattern 0 0 (boolean (true)))    # �݂͂̓h��X�^�C��
        (textHeight 0)                          # ������̍���
        (visible (boolean (true)))              # �\���L��
        (property ...)
        (includeFigureGroup ...)
        ...
    )
```

figureGroup �̖��O�́A�c�[���ˑ��ł��邪�A��Ɉȉ�������B

* PINNUMBER
* PINNAME
: PARTREFERENCE
* PARTVALUE
* DISPLAYPROPERTY
* WIRE
* PARTBODY
* OFFPAGECONNECTORTEXT
* TITLEBLOCK
* PAGEBORDER
* COMMENTTEXT

�\�����̗v�f�� `figureGroupOverride` ���邱�ƂŁA�ꎞ�I�� `figureGroup` �̐ݒ��u�������Ďg�p����B  

---

## cell

`cell` �́A������ `view` �������Ƃ��ł���B  
`cell` �́A `cellType` �ŃZ���̎�ʂ��`����B  

```lisp
    (cell [nameDef]                 # cell �̒�`
        (cellType TIE/RIPPER/GENERIC)
        (status ...)
        (viewMap ...)
        (view [nameDef] ...)...     # view �̒�`
        (property...)...
    )...
```

## cellType

* `TIE`     -- ?
* `RIPPER`  -- �o�X�̌����_
* `GENERIC` -- �}�`

## viewMap

`view` �̃}�b�s���O�B�o�b�N�A�m�e�[�V�����Ȃǂ��T�|�[�g����B  
`port` �̃}�b�s���O�Ƃ��� `portRef`, `portGroup` ���g�p����B

```lisp
    (viewMap
        (portMap (portRef)... (portGroup [nameRef]/(portRef)...)...)...
        (portBackAnotate (portRef) ...)... 
        (instanceMap (instanceRef)... (instanceGroup)...)... 
        (instanceBackAnotate (instanceRef) ...)... 
        (netMap (netRef)... (netGroup)...)... 
        (netBackAnotate ...)...
    )...
```

## view

`view` �́A`interface` �� `contents` �����B  
`view` �́A `viewType` �ŃZ���̎�ʂ��`����B  

```lisp
    (view [nameDef]                             # view �̒�`
        (viewType SCHEMATIC/GRAPHIC/...)
        (status ...)
        (interface ...)                         # interface �̒�`
        (contents ...)                          # contents �̒�`
        (property ...)...
    )...
```

## viewType

��{

* `SCHEMATIC` -- ��H���i�}�`
* `GRAPHIC` -- ��H�}�`

���̂ق�

* `MASKLAYOUT`
* `PCBLAYOUT`
* `NETLIST`
* `SYMBOLIC`
* `BEHAVIOR`
* `LOGICMODEL`
* `DOCUMENT`
* `STRANGER`

---

## interface

`cell` �̃C���^�[�t�F�[�X���`����B

```lisp
    (interface                                  # interface �̒�`
        (port ...)...
        (portBundle ...)...
        (symbol ...)...
        (protectionFrame ...)...
        (designator ""/(stringDisplay))... 
        (parameter [nameDef] [typedValue] (Uint)?)... 
        (property ...)...

        # others
        (arrayrelatedinfo (baseArray)/(arraySite)(arrayMacro))...
        (joined (portRef)... (portList)... (globalPortRef)...)... 
        (weakJoined (portRef)... (portList)... (joined)...)... 
        (mustJoin (portRef)... (portList)... (weakJoined)... (joined)...)... 
        (permutable ...)... 
        (timing ...)... (simurate ...)... 
    )
```

## contents

`contents` �́A`cellType`/`viewType` �̑g�ݍ��킹�ɂ��g�p����v�f���قȂ�B

* ��H�}�̏ꍇ ( viewType = `SCHEMATIC` )

```lisp
    (contents                                   # contents �̒�`
        (offPageConnector ...)...
        (page "" 
            (pageSize (rectangle (pt) (pt)))
            (instance ...)
            (net ...)
            (netBundle ...)
            (commentgraphics ...)
            (portimplementation ...)
            (boundingBox (rectangle (pt) (pt)))...
        )...
    )...
```

* �}�`�̏ꍇ ( viewType=`GRAPHIC` )

```lisp
    (contents                                   # contents �̒�`
        (figure ...)...                          # �}�`
        (instance ...)...
        (net ...)...
        (netBundle ...)...
        (commentGraphics ...)...
        (portimplementation)...
        (boundingBox (rectangle (pt) (pt)))...
    )...
```

* ���̂ق�

```lisp
    (contents                                   # contents �̒�`
        (figure...)...                          # �}�`
        (section "" (section...)/""/(instance...)...)...
        (net...)...
        (netBundle...)...
        (commentGraphics 
            (annotate...) 
            (figure...) 
            (instance...) 
            (boundingbox...) 
            (property...)
        )...
        (portimplementation)...
        (boundingBox (rectangle (pt) (pt)))...
        (timing ...)... (simulate ...)... (when ...)...
        (follow ...)... (logicPort ...)...
    )...
```

---

## value

�l�́Aboolean�l, �����l, �����l, ���W, ������, ��Ԃ�����B
��Ԃ̓V�~�����[�V�����p�B

```lisp
    BOOL  = (true)/(false)                                          # Boolean�l(true/false)
    INT   = 0                                                       # �����l
    NUM   = 0/(e 0 0)                                               # �����l(a*10^(6+b))
    POINT = (pt 0 0)                                                # ���W(x y)
    STR   = ""                                                      # ������
    MNM   = 0/(e 0 0)/(mnm 0/(e 0 0)/(undefined)/(unconstrained)    # ���
                           0/(e 0 0)/(undefined)/(unconstrained)
                           0/(e 0 0)/(undefined)/(unconstrained))
```

## typedValue

�^�t���l�́Aboolean, integer, number, point, string, minomax ������B
���ꂼ��̒l�Ɍ^��K�p����Bminomax �̓V�~�����[�V�����p�B

```lisp
    (boolean [BOOL]/(booleanDisplay [BOOL] (display...))/(boolean...) ...)          # Bool�l
    (integer [INT]/(intDisplay      [INT] (display...))/(integer...) ...)           # �����l
    (number  [NUM]/(numberDisplay   [NUM] (display...))/(number...) ...)            # ���l
    (point [POINT]/(pointDisp     [POINT] (display...))/(point...) ...)             # ���W
    (string  [STR]/(stringDisplay   [STR] (display...))/(string...) ...)            # ������
    (minoMax [MNM]/(minoMaxDisplay  [MNM] (display...))/(minoMax...) ...)           # ���
```

---

## �Q�ƕ\��

```lisp
    (keywordDisplay [ident] (display...))                           # �L�[���[�h���Q�Ƃ��ĕ\��
    (propertyDisplay [nameRef] (display...))                        # �v���p�e�B���Q�Ƃ��ĕ\��
    (parameterDisplay [nameRef] (display...))                       # �p�����[�^���Q�Ƃ��ĕ\��
```

### keywordDisplay

keyword �Œ�`���ꂽ���ږ��� ident �̒l��\��

* portImplementation �� name �� port �̍��ږ� ident �̒l
* protectionFrame (�s��)
* symbol (�s��)

### propertyDisplay

property �Œ�`���ꂽ���O�� nameRef �̒l��\��

* portImplementation �� property �̖��O�� nameRef �̒l
* protectionFrame �� property �̖��O�� nameRef �̒l
* symbol �� property �̖��O�� nameRef �̒l

### parameterDisplay

cell/interface/parameter �Œ�`���ꂽ���O�� nameRef �̒l��\��

* protectionFrame (�s��)
* symbol (�s��)

---

## display

�\��������ݒ�

```lisp
    (display
        [nameRef]/(figureGroupoverride ...)
        (justify CENTERCENTER/CENTERLEFT/CENTERRIGHT/               # �A���J�[�ʒu�w��
                 LOWERCENTER/LOWERLEFT/LOWERRIGHT/
                 UPPERCENTER/UPPERLEFT/UPPERRIGHT)
        (orientation R0/R90/R270/MX/MY/MYR90/MXR90)                 # ��]
        (origin (pt 0 0))                                           # ���W
    )
```

---

## figure

�}�`���`����B\
figure �� nameRef �Ŏw�肵�� figureGroup �̐ݒ�������p���B����ɕ����I�ɐݒ��ύX����ꍇ�́A figureGroupOverride �ŏ㏑������B

```lisp
    (figure [nameRef]/(FigureGroupoverride ...)
        (circle (pt 0 0) (pt 0 0) (property ...)...)            # ��_�Ԃ𒼌a�Ƃ����~
        (dot (pt 0 0) (property ...)...)                        # �_
        (path (pointList (pt 0 0)...) (property ...)...)        # pointList �̊e�_�����Ԃɒ����Őڑ�
        (polygon (pointList (pt 0 0)...) (property ...)...)     # pointList �̊e�_�����Ԃɒ����Őڑ����Ō�ƍŏ��̓_���ڑ�
        (rectangle (pt 0 0) (pt 0 0) (property)...)             # 2�_��Ίp�Ƃ����l�p�`
        (shape/openShape 
            (curve
                (arc (pt 0 0) (pt 0 0) (pt 0 0))...             # �~�� (�J�n�_�A���ԓ_�A�I���_)
                (pt 0 0)...                                     # �e�_�����Ԃɐڑ������Ȑ�
            )
            (property ...)...
        )
    )
```

** shape �� openShape �̍��͕s��(�J�n�_�̏I���_��ڑ����邩���Ȃ����̈Ⴂ�H)

`figure` �́A`figureGroup` �̖��O�Ő}�`��`�悷��B  
`figureArea` , `figureRepimeter` , `figureWidth`

## figureGroupOverride

figureGroup �̑����̈ꕔ���㏑������������K�p�Ώۂɂ���B

```lisp
    (figureGroupOverride
        (figureGroupRef [nameRef] (LibraryRef [nameRef])?)
        (...)           # figureGroup �̊e���ځB������ includeFigureGroup �͏���
        ...
    )
```

---

## commentGraphics

�R�����g�}�`���`����B

```lisp
    (commentGraphics
        (figure ...)...
        (instance ...)...
        (annotate ....)...
        (boundingBox ...)
        (property ...)...
    )
```

## symbol

�V���{���̐}

```lisp
    (symbol
        (portimplementation)
        (figure)
        (instance)
        (commentGraphics)
        (annotate)
        (pageSize)
        (boundingBox)
        (propertyDisplay)
        (KeywordDisplay)
        (ParameterDisplay)
        (Property)
    )
```

nameRef:

```lisp
    [Ident]
    (Name [Ident]
        (Display
            [FigGrpNameRef]/(FigureGroupride
                (FigureGroupRef [FigGrpNameRef] (LibraryRef [name])?)
                (CornerType)
                (EndType)
                (PathWidth)
                (BorderWidth)
                (Color)
                (FillPattern)
                (BorderPat)
                (TextHeight)
                (Visible)
                (Property)
            )
            (justify 
                CENTERCENTER/CENTERLEFT/CENTERRIGHT/
                LOWERCENTER/LOWERLEFT/LOWERRIGHT/
                UPPERCENTER/UPPERLEFT/UPPERRIGHT
            )
            (orientation R0/R90/R270/MX/MY/MYR90/MXR90)
            (Origin (pt 0 0))
        )
    )

    (viewRef [nameRef] (CellRef [nameRef] (LibraryRef [nameRef])?)?)
```

---

## instance

```lisp
    (instance [nameDef]
        (viewRef [nameRef] (cellRef [nameRef] (libraryRef [nameRef])))
        (viewList (viewRef..)... (viewList...)...)
        (Transform)...
        (parameterAssign)...
        (PortInstance)...
        (timing)...
        (designator)...
        (property)...
    )
```

```lisp
    (portInstance [nameRef]/(portRef)
        (unused...)
        (portDelay...)
        (designator...)
        (dcFanInLoad...)
        (dcFanOutLoad...)
        (dcMaxFanIn...)
        (dcMaxFanOut...)
        (acLoad...)
        (property...)
    )
```

---

## net / netBundle

use: `page`, `contents`

�l�b�g���`����B

```lisp
    (net [nameDef]              #�l�b�g��
        (joined)
        (criticality)...
        (netDelay)...
        (net)...
        (instance)...
        (figure)...
        (commonGraphics)...
        (property)...
    )

    (netBundle [nameDef]        #�l�b�g�o���h����
        (listOfNets (net)...)
        (figure)...
        (commentGraphics)...
        (property)...
    )
```

## joined

use: `interface`, `net`

�|�[�g�Ԃ̂Ȃ�����w�肷��B

```lisp
    (joined
        (portRef [NameDef] (instanceRef [NameDef]))...
        (portList)...
        (globalPortRef)...
    )... 

    (weakJoined (portRef)... (portList)... (joined)...)
    (mustJoin (portRef)... (portList)... (weakJoined)... (joined)...)
```

## port

�|�[�g�̒�`

```lisp
    (port ""
        (direction INOUT/INPUT/OUTPUT)
        (unused ...)
        (portDelay ...)
        (designator ""/(strDisplay))
        (DcFanInLoad) (DcFanOutLoad) (DcMaxFanIn) (DcMaxFanOut) (AcLoad)
        (Property ...)...
    )
```

```lisp
    (portBundle ""
        (listOfPorts (port ...)... (portBundle ...)...)
        (Property ...)...
    )
```

�|�[�g�̎���

```lisp
    (portImplementation
        (Name)/[Ident]
        (figure)
        (connectLocation)
        (instance)
        (commentGraphics)
        (propertyDisplay)
        (KeywordDisplay)
        (Property)
    )
```

---

```lisp
    (protectionFrame
        (portImplementation)...
        (figure)
        (instance)
        (commentGraphics)
        (boundingBox)
        (PropDisp) 
        (KeywordDisplay) 
        (parameterDisplay [nameRef] (display)) 
        (Property)
    )
```

```lisp
    (instanceRef "" (InstanceRef)? (viewRef)?)
    (netRef "" (netRef)? (instanceRef)? (viewRef)?)
    (portRef "" (portRef)? (instanceRef)? (viewRef)?)
    (site (viewRef) (trasform)?)
    (viewList (viewRef)... (viewList)...)

    (figureGroupRef "" (LibraryRef "")?)

    (globalportRef)
```

---

## property

�J�X�^���̑������`����B

```lisp
    (Property [nameDef]
        (TypedValue ...)
        (Owner "")?
        (Unit 
            DISTANCE/CAPACITANCE/CURRENT/RESISTANCE/TEMPERATURE/
            TIME/VOLTAGE/MASS/FREQUENCY/INDUCTANCE/ENERGY/POWER/
            CHARGE/CONDUCTANCE/FLUX/ANGLE
        )?
        (Property ...)?
    )
```

## comment

�����ȂƂ���Œ�`�ł���B�g��Ȃ��̂ŏ�ɖ����B

```lisp
    (comment "")
```

## userData

�����ȂƂ���Œ�`�ł���B�g��Ȃ��̂ŏ�ɖ����B

```lisp
    (userData [ident]
        [Int]/[Str]/[Ident]/(Keyword [Int]/[Str]/[Ident]/(Keyword ...))
    )
```
