# edif structure

## root of edif

edif �̎�v���ڂ́Aexternal, library, design �ł���B

library �́A������ cell �����C�u�����Ƃ��Ă܂Ƃ߂����̂ł���Bexternal �́Alibrary �Ɠ����@�\�ł��邪�A�S�̓I�������͕����I�ɊO�����C�u�������Q�Ƃ���B

cell �͕��i�ɑ������A���i�̕\�����@�Ƃ��ĕ����� view �������Ƃ��o����Bview �ɂ� interface �� contents ������Ainterface �̓C���^�[�t�F�[�X���`���A contents �͒��g���`����B

design �́Aedif �t�@�C���̃g�b�v�f�U�C�� cell �֎Q�Ƃ���B

    (edif
        [edifFileName]
        (edifVersion 2 0 0)
        (edifLevel 1)
        (keywordMap (keywordLevel 0))
        (status ...)
        (external [nameDef] ...)...                             # �O�����C�u�����ւ̎Q��
        (library [nameDef]                                      # �������C�u�����̒�`
            (edifLevel 1)
            (status ...)
            (technology ...)                                    # �c�[���ݒ�
            (cell [nameDef]                                     # cell �̒�`
                (cellType TIE/RIPPER/GENERIC)
                (status ...)
                (viewMap ...)
                (view [nameDef]                                 # view �̒�`
                    (viewType MASKLAYOUT/PCBLAYOUT/NETLIST/
                              SCHEMATIC/SYMBOLIC/BEHAVIOR/
                              LOGICMODEL/DOCUMENT/GRAPHIC/
                              STRANGER)
                    (status ...)
                    (interface                                  # interface �̒�`
                        (port ...)...
                        (portBundle ...)...
                        (symbol ...)...
                        (protectionFrame ...)...
                        (designator ""/(stringDisplay))... 
                        (parameter [nameDef] [typedValue] (Uint)?)... 
                        (property ...)...

                        # others
                        (arrayrelatedinfo (baseArray)/(arraySite)/(arrayMacro))...
                        (joined (portRef)... (portList)... (globalPortRef)...)... 
                        (weakJoined (portRef)... (portList)... (joined)...)... 
                        (mustJoin (portRef)... (portList)... (weakJoined)... (joined)...)... 
                        (permutable ...)... 
                        (timing ...)... (simurate ...)... 
                    )
                    (contents                                   # contents �̒�`
                        (offPageConnector...)...
                        (figure...)...
                        (section "" (section...)/""/(instance...)...)...
                        (instance...)...
                        (page "" 
                            (pageSize (rectangle (pt) (pt)))
                            (instance...)
                            (net...)
                            (netBundle...)
                            (commentgraphics...)
                            (portimplementation...)
                            (boundingbox...)
                        )...
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
                        (boundBox (rectangle (pt) (pt)))...
                        (timing ...)... (simulate ...)... (when ...)...
                        (follow ...)... (logicPort ...)...
                    )...
                    (property...)...
                )...
                (property...)...)...
        )...
        (design [nameDef] 
            (cellRef [nameRef] (libraryRef nameRef)?)
            (status...)...
            (property...)...
        )
    )

** comment/userData ���e���ɓ�����邪�����ł͖������邱�ƂƂ���B

---

## sutatus

edif, external, library, cell, view, design �̏��̑�����`

    (status
        (written
            (timeStamp 0 0 0 0 0 0)                     # �쐬��
            (author "")...                              # �쐬��
            (program "" (version "")?)...               # �����c�[�����ƃc�[���o�[�W����
            (dataOrigin "" (version "")?)...            # ���f�[�^�̍쐬�c�[�����ƃc�[���̃o�[�W����
            (property...)...
        )
    )

## technorogy

external/library �̐݌v����`

    (technology
        (numberDefinition                               # �݌v���
            (scale 0/(e 0 0) 0/(e 0 0) (unit ...))...   # ����w��
            (gridMap 0/(e 0 0) 0/(e 0 0))...
        )
        (figureGroup ...)...                            # �}�`�����ݒ�
        (fabricate [nameDef] [nameRef])...              # ���C���ɑΉ������}�`�����̑Ή��ݒ�
        (simulationInfo ...)...                         # �V�~�����[�V�������
        (physicalDesignRule ...)...                     # �����݌v���[�����
    )

## unit

    �P�ʂ̎��

    (unit DISTANCE/CAPACITANCE/CURRENT/RESISTANCE/TEMPERATURE/
          TIME/VOLTAGE/MASS/FREQUENCY/INDUCTANCE/ENERGY/POWER/
          CHARGE/CONDUCTANCE/FLUX/ANGLE)

use: scale, parameter, property

��) (e 254 -6) => 254*10^(6-6)=254 cm

## viewMap

�l�̒P��

    (viewMap
        (portMap (portRef)... (portGroup)...)...
        (portBackAnotate (portRef) ...)... 
        (instanceMap (instanceRef)... (instanceGroup)...)... 
        (instanceBackAnotate (instanceRef) ...)... 
        (netMap (netRef)... (netGroup)...)... 
        (netBackAnotate ...)...
    )...

---

## value

�l�́Aboolean�l, �����l, �����l, ���W, ������, ��Ԃ�����B
��Ԃ̓V�~�����[�V�����p�B

    BOOL  = (true)/(false)                                          # Boolean�l(true/false)
    INT   = 0                                                       # �����l
    NUM   = 0/(e 0 0)                                               # �����l(a*10^(6+b))
    POINT = (pt 0 0)                                                # ���W(x y)
    STR   = ""                                                      # ������
    MNM   = 0/(e 0 0)/(mnm 0/(e 0 0)/(undefined)/(unconstrained)    # ���
                           0/(e 0 0)/(undefined)/(unconstrained)
                           0/(e 0 0)/(undefined)/(unconstrained))

## typedValue

�^�t���l�́Aboolean, integer, number, point, string, minomax ������B
���ꂼ��̒l�Ɍ^��K�p����Bminomax �̓V�~�����[�V�����p�B

    (boolean [BOOL]/(booleanDisplay [BOOL] (display...))/(boolean...) ...)          # Bool�l
    (integer [INT]/(intDisplay      [INT] (display...))/(integer...) ...)           # �����l
    (number  [NUM]/(numberDisplay   [NUM] (display...))/(number...) ...)            # ���l
    (point [POINT]/(pointDisp     [POINT] (display...))/(point...) ...)             # ���W
    (string  [STR]/(stringDisplay   [STR] (display...))/(string...) ...)            # ������
    (minoMax [MNM]/(minoMaxDisplay  [MNM] (display...))/(minoMax...) ...)           # ���

---

## �Q�ƕ\��

    (keywordDisplay [ident] (display...))                           # �L�[���[�h���Q�Ƃ��ĕ\��
    (propertyDisplay [nameRef] (display...))                        # �v���p�e�B���Q�Ƃ��ĕ\��
    (parameterDisplay [nameRef] (display...))                       # �p�����[�^���Q�Ƃ��ĕ\��

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

    (display
        [nameRef]/(figureGroupoverride ...)
        (justify CENTERCENTER/CENTERLEFT/CENTERRIGHT/               # �A���J�[�ʒu�w��
                 LOWERCENTER/LOWERLEFT/LOWERRIGHT/
                 UPPERCENTER/UPPERLEFT/UPPERRIGHT)
        (orientation R0/R90/R270/MX/MY/MYR90/MXR90)                 # ��]
        (origin (pt 0 0))                                           # ���W
    )

---

## ref

### library �Q��

    (libraryRef name)

### cell �Q��

use : design

    (cellRef name)
    (cellRef name (libraryRef name))

### view �Q��

use : instance, site, viewList

    (viewRef name)
    (viewRef name (cellRef name))
    (viewRef name (cellRef name (libraryRef name)))

### figureGroup �Q��

use : includeFigureGroup, intersection, inverse, overSize, union, difference, figureGroupObject

    (figureGroupRef name)
    (figureGroupRef name (libraryRef name))

### globalPort �Q��

use : joined

    (globalPortRef name)

### port �Q��

use : portGroup, portInstance, portList, portMap, steady, tableDefault, weekJoined, change, entry, event, follow, logicAssign, loginInput, logicOutput, maintain, match, mustJoin, nonPermut, Permutable, portBackAnotate

    (portRef name)
    (portRef name (portRef name (...)))
    (portRef name (viewRef name))
    (portRef name (viewRef name (cellRef name)))
    (portRef name (viewRef name (cellRef name (libraryRef name))))
    (portRef name (instanceRef name))
    (portRef name (instanceRef name (viewRef name)))
    (portRef name (instanceRef name (viewRef name (cellRef name))))
    (portRef name (instanceRef name (viewRef name (cellRef name (libraryRef name)))))

### net �Q��

use : netGroup, netMap, event, netBackAnnotate

    (netRef name)
    (netRef name (netRef name (...)))
    (netRef name (viewRef name))
    (netRef name (viewRef name (cellRef name)))
    (netRef name (viewRef name (cellRef name (libraryRef name))))
    (netRef name (instanceRef name))
    (netRef name (instanceRef name (viewRef name)))
    (netRef name (instanceRef name (viewRef name (cellRef name))))
    (netRef name (instanceRef name (viewRef name (cellRef name (libraryRef name)))))

### logic �Q��

�V�~�����[�V�����p

    (logicRef name)
    (logicRef name (libraryRef name))

---

## figure

�}�`���`����B\
figure �� nameRef �Ŏw�肵�� figureGroup �̐ݒ�������p���B����ɕ����I�ɐݒ��ύX����ꍇ�́A figureGroupOverride �ŏ㏑������B

    (figure [nameRef]/(FigureGroupoverride ...)
        (dot (pt 0 0) (property)...)                            # �_
        (circle (pt 0 0) (pt 0 0) (property ...)...)            # ��_�Ԃ𒼌a�Ƃ����~
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

** shape �� openShape �̍��͕s��(�J�n�_�̏I���_��ڑ����邩���Ȃ����̈Ⴂ�H)

## figureGroup

�}�̐ݒ�𖼑O��t���Ē�`����B

    (figureGroup [nameDef]
        (cornerType EXTEND/ROUND/TRUNCATE)          # �p�̌`��w�� (�L�΂��A�ۂ߂�A�؂�l�߂�)
        (endType EXTEND/ROUND/TRUNCATE)             # �n�_�E�I�_�̌`��w��
        (pathWidth 0)                               # ����
        (borderWidth 0)                             # �͂ݘg�̕�
        (color 0 0 0)                               # �F (�l�͐����l���X�P�[���l�A�e���͈̔͂�0-100?)
        (fillPattern 0 0 (boolean (true)))          # �h��X�^�C��
        (borderPattern 0 0 (boolean (true)))        # �݂͂̓h��X�^�C��
        (textHeight 0)                              # ������̍���
        (visible (boolean (true)))                  # �\���L��
        (property ...)
        (includeFigureGroup ...)
        ...
    )

## figureGroupOverride

figureGroup �̑����̈ꕔ���㏑������������K�p�Ώۂɂ���B

    (figureGroupOverride
        (figureGroupRef [nameRef] (LibraryRef [nameRef])?)
        (...)           # figureGroup �̊e���ځB������ includeFigureGroup �͏���
        ...
    )

## ���̂ق�

    (port ""
        (direction INOUT/INPUT/OUTPUT)
        (unused)
        (portDelay ...)
        (designator ""/(strDisplay))
        (DcFanInLoad) (DcFanOutLoad) (DcMaxFanIn) (DcMaxFanOut) (AcLoad)
        (Property)...
    )

    (portBundle ""
        (listOfPorts (port)... (portBundle)...)
        (Property)...
    )

    (symbol
        (portimplementation)
        (figure)
        (instance)
        (commentGraphics)
        (annotate)
        (pageSize)
        (boundBox)
        (propertyDisplay)
        (KeywordDisplay)
        (ParameterDisplay)
        (Property)
    )

    (protectionFrame
        (portImplementation)...
        (figure)
        (instance)
        (commentGraphics)
        (boundBox)
        (PropDisp) 
        (KeywordDisplay) 
        (parameterDisplay [nameRef] (display)) 
        (Property)
    )

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

nameRef:

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

## instance

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

## net

    (net [nameDef]
        (joined)
        (criticality)
        (netDelay)
        (figure)
        (net)
        (instance)
        (commonGraphics)
        (property)
    )

    (instanceRef "" (InstanceRef)? (viewRef)?)
    (netRef "" (netRef)? (instanceRef)? (viewRef)?)
    (portRef "" (portRef)? (instanceRef)? (viewRef)?)
    (site (viewRef) (trasform)?)
    (viewList (viewRef)... (viewList)...)

    (figureGroupRef "" (LibraryRef "")?)

    (globalportRef)

## property

    (Property namedef
        (TypedValue ...)
        (Owner "")?
        (Unit 
            DISTANCE/CAPACITANCE/CURRENT/RESISTANCE/TEMPERATURE/
            TIME/VOLTAGE/MASS/FREQUENCY/INDUCTANCE/ENERGY/POWER/
            CHARGE/CONDUCTANCE/FLUX/ANGLE
        )?
        (Property ...)?
    )

## comment

�����ȂƂ���Œ�`�ł���B�g��Ȃ��̂ŏ�ɖ����B

    (comment "")

## userData

�����ȂƂ���Œ�`�ł���B�g��Ȃ��̂ŏ�ɖ����B

    (userData [ident]
        [Int]/[Str]/[Ident]/(Keyword [Int]/[Str]/[Ident]/(Keyword ...))
    )

## NameDef

    [Ident]
    [Ident] (Name [Ident] (Display))
    [Ident] (Rename [Ident](Name [Ident] (Display)) ""/(strDisplay))

