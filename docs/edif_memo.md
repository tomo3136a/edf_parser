# edif structure

## root of edif

edif の主要項目は、external, library, design である。

library は、複数の cell をライブラリとしてまとめたものである。external は、library と同じ機能であるが、全体的もしくは部分的に外部ライブラリを参照する。

cell は部品に相当し、部品の表示方法として複数の view を持つことが出来る。view には interface と contents があり、interface はインターフェースを定義し、 contents は中身を定義する。

design は、edif ファイルのトップデザイン cell へ参照する。

    (edif
        [edifFileName]
        (edifVersion 2 0 0)
        (edifLevel 1)
        (keywordMap (keywordLevel 0))
        (status ...)
        (external [nameDef] ...)...                             # 外部ライブラリへの参照
        (library [nameDef]                                      # 内部ライブラリの定義
            (edifLevel 1)
            (status ...)
            (technology ...)                                    # ツール設定
            (cell [nameDef]                                     # cell の定義
                (cellType TIE/RIPPER/GENERIC)
                (status ...)
                (viewMap ...)
                (view [nameDef]                                 # view の定義
                    (viewType MASKLAYOUT/PCBLAYOUT/NETLIST/
                              SCHEMATIC/SYMBOLIC/BEHAVIOR/
                              LOGICMODEL/DOCUMENT/GRAPHIC/
                              STRANGER)
                    (status ...)
                    (interface                                  # interface の定義
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
                    (contents                                   # contents の定義
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

** comment/userData を各所に入れられるがここでは無視することとする。

---

## sutatus

edif, external, library, cell, view, design の情報の属性定義

    (status
        (written
            (timeStamp 0 0 0 0 0 0)                     # 作成日
            (author "")...                              # 作成者
            (program "" (version "")?)...               # 生成ツール名とツールバージョン
            (dataOrigin "" (version "")?)...            # 元データの作成ツール名とツールのバージョン
            (property...)...
        )
    )

## technorogy

external/library の設計情報定義

    (technology
        (numberDefinition                               # 設計情報
            (scale 0/(e 0 0) 0/(e 0 0) (unit ...))...   # 基準を指定
            (gridMap 0/(e 0 0) 0/(e 0 0))...
        )
        (figureGroup ...)...                            # 図形属性設定
        (fabricate [nameDef] [nameRef])...              # レイヤに対応した図形属性の対応設定
        (simulationInfo ...)...                         # シミュレーション情報
        (physicalDesignRule ...)...                     # 物理設計ルール情報
    )

## unit

    単位の種別

    (unit DISTANCE/CAPACITANCE/CURRENT/RESISTANCE/TEMPERATURE/
          TIME/VOLTAGE/MASS/FREQUENCY/INDUCTANCE/ENERGY/POWER/
          CHARGE/CONDUCTANCE/FLUX/ANGLE)

use: scale, parameter, property

例) (e 254 -6) => 254*10^(6-6)=254 cm

## viewMap

値の単位

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

値は、boolean値, 整数値, 小数値, 座標, 文字列, 状態がある。
状態はシミュレーション用。

    BOOL  = (true)/(false)                                          # Boolean値(true/false)
    INT   = 0                                                       # 整数値
    NUM   = 0/(e 0 0)                                               # 小数値(a*10^(6+b))
    POINT = (pt 0 0)                                                # 座標(x y)
    STR   = ""                                                      # 文字列
    MNM   = 0/(e 0 0)/(mnm 0/(e 0 0)/(undefined)/(unconstrained)    # 状態
                           0/(e 0 0)/(undefined)/(unconstrained)
                           0/(e 0 0)/(undefined)/(unconstrained))

## typedValue

型付き値は、boolean, integer, number, point, string, minomax がある。
それぞれの値に型を適用する。minomax はシミュレーション用。

    (boolean [BOOL]/(booleanDisplay [BOOL] (display...))/(boolean...) ...)          # Bool値
    (integer [INT]/(intDisplay      [INT] (display...))/(integer...) ...)           # 整数値
    (number  [NUM]/(numberDisplay   [NUM] (display...))/(number...) ...)            # 数値
    (point [POINT]/(pointDisp     [POINT] (display...))/(point...) ...)             # 座標
    (string  [STR]/(stringDisplay   [STR] (display...))/(string...) ...)            # 文字列
    (minoMax [MNM]/(minoMaxDisplay  [MNM] (display...))/(minoMax...) ...)           # 状態

---

## 参照表示

    (keywordDisplay [ident] (display...))                           # キーワードを参照して表示
    (propertyDisplay [nameRef] (display...))                        # プロパティを参照して表示
    (parameterDisplay [nameRef] (display...))                       # パラメータを参照して表示

### keywordDisplay

keyword で定義された項目名が ident の値を表示

* portImplementation の name が port の項目名 ident の値
* protectionFrame (不明)
* symbol (不明)

### propertyDisplay

property で定義された名前が nameRef の値を表示

* portImplementation の property の名前が nameRef の値
* protectionFrame の property の名前が nameRef の値
* symbol の property の名前が nameRef の値

### parameterDisplay

cell/interface/parameter で定義された名前が nameRef の値を表示

* protectionFrame (不明)
* symbol (不明)

---

## display

表示属性を設定

    (display
        [nameRef]/(figureGroupoverride ...)
        (justify CENTERCENTER/CENTERLEFT/CENTERRIGHT/               # アンカー位置指定
                 LOWERCENTER/LOWERLEFT/LOWERRIGHT/
                 UPPERCENTER/UPPERLEFT/UPPERRIGHT)
        (orientation R0/R90/R270/MX/MY/MYR90/MXR90)                 # 回転
        (origin (pt 0 0))                                           # 座標
    )

---

## ref

### library 参照

    (libraryRef name)

### cell 参照

use : design

    (cellRef name)
    (cellRef name (libraryRef name))

### view 参照

use : instance, site, viewList

    (viewRef name)
    (viewRef name (cellRef name))
    (viewRef name (cellRef name (libraryRef name)))

### figureGroup 参照

use : includeFigureGroup, intersection, inverse, overSize, union, difference, figureGroupObject

    (figureGroupRef name)
    (figureGroupRef name (libraryRef name))

### globalPort 参照

use : joined

    (globalPortRef name)

### port 参照

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

### net 参照

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

### logic 参照

シミュレーション用

    (logicRef name)
    (logicRef name (libraryRef name))

---

## figure

図形を定義する。\
figure の nameRef で指定した figureGroup の設定を引き継ぐ。さらに部分的に設定を変更する場合は、 figureGroupOverride で上書きする。

    (figure [nameRef]/(FigureGroupoverride ...)
        (dot (pt 0 0) (property)...)                            # 点
        (circle (pt 0 0) (pt 0 0) (property ...)...)            # 二点間を直径とした円
        (path (pointList (pt 0 0)...) (property ...)...)        # pointList の各点を順番に直線で接続
        (polygon (pointList (pt 0 0)...) (property ...)...)     # pointList の各点を順番に直線で接続し最後と最初の点も接続
        (rectangle (pt 0 0) (pt 0 0) (property)...)             # 2点を対角とした四角形
        (shape/openShape 
            (curve
                (arc (pt 0 0) (pt 0 0) (pt 0 0))...             # 円弧 (開始点、中間点、終了点)
                (pt 0 0)...                                     # 各点を順番に接続した曲線
            )
            (property ...)...
        )
    )

** shape と openShape の差は不明(開始点の終了点を接続するかしないかの違い？)

## figureGroup

図の設定を名前を付けて定義する。

    (figureGroup [nameDef]
        (cornerType EXTEND/ROUND/TRUNCATE)          # 角の形状指定 (伸ばす、丸める、切り詰める)
        (endType EXTEND/ROUND/TRUNCATE)             # 始点・終点の形状指定
        (pathWidth 0)                               # 線幅
        (borderWidth 0)                             # 囲み枠の幅
        (color 0 0 0)                               # 色 (値は整数値かスケール値、各項の範囲は0-100?)
        (fillPattern 0 0 (boolean (true)))          # 塗りスタイル
        (borderPattern 0 0 (boolean (true)))        # 囲みの塗りスタイル
        (textHeight 0)                              # 文字列の高さ
        (visible (boolean (true)))                  # 表示有無
        (property ...)
        (includeFigureGroup ...)
        ...
    )

## figureGroupOverride

figureGroup の属性の一部を上書きした属性を適用対象にする。

    (figureGroupOverride
        (figureGroupRef [nameRef] (LibraryRef [nameRef])?)
        (...)           # figureGroup の各項目。ただし includeFigureGroup は除く
        ...
    )

## そのほか

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

いろんなところで定義できる。使わないので常に無視。

    (comment "")

## userData

いろんなところで定義できる。使わないので常に無視。

    (userData [ident]
        [Int]/[Str]/[Ident]/(Keyword [Int]/[Str]/[Ident]/(Keyword ...))
    )

## NameDef

    [Ident]
    [Ident] (Name [Ident] (Display))
    [Ident] (Rename [Ident](Name [Ident] (Display)) ""/(strDisplay))

