# XFDFファイルフォーマット

## 概要

XFDF ファイルは、 FDF ファイルの XML ファイル版である。
フォームデータと注釈を保存する。

## 拡張子

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
                subject="長方形" title="tomo3">
                <popup flags="print,nozoom,norotate" open="no" page="0" 
                    rect="612.000000,673.000000,816.000000,787.000000"/>
            </square>
        </annots>
        <f href="xxx.pdf"/>
        <ids original="D44B3069C43280202DC5423980241179" 
            modified="B45F09C7D1006DEBF9E6EC5B88B0E834"/>
    </xfdf>
```

## ルート

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
        ...
        <f href="xxx.pdf"/>
        <ids original="D44B3069C43280202DC5423980241179" 
            modified="B45F09C7D1006DEBF9E6EC5B88B0E834"/>
    </xfdf>
```

* rootは、`<xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">`とする
* `<f href="...">` はpdfファイルへのリンク。無くてもよい。
* `<ids original="..." modified="...">` はpdfファイルへのリンク情報。無くてもよい。
* `<xfdf ...>`の下にフォーム`<fields>`やコメント`<annots>`を配置する。

## フォームデータ

`<fields>` 内にフォームデータを配置する。

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
        <fields>
            ...
        </fields>
        <f href="xxx.pdf"/>
        <ids original="D44B3069C43280202DC5423980241179" 
            modified="B45F09C7D1006DEBF9E6EC5B88B0E834"/>
    </xfdf>
```

### 単純フォームデータ

フォームデータは、`<field ...>`の`name`属性をキーとし、`<value>`に値を指定する。

```xml
    <fields>
        <field name=”Name”>
            <value>Adobe Systems, Inc.</value>
        </field>
        <field name=”Street”>
            <value>345 Park Ave.</value>
        </field>
        ...
    </fields>
```

### 階層構造

`<field>`は入れ子にでき、グルーピングできる。

```xml
    <fields>
        <field name=”Address”>
            <field name=”Name”>
                <value>Adobe Systems, Inc.</value>
            </field>
            <field name=”Street”>
                <value>345 Park Ave.</value>
            </field>
            ...
        </field>
    </fields>
```

値は、`<value>`の代わりに`<value-ritchtext>`を使用するとリッチテキストとして使用できる。

```xml
    <value-richtext>
        <body xmlns="http://www.w3.org/1999/xhtml"
            xmlns:xfa="http://www.xfa.org/schema/xfa-data/1.0/" 
            xfa:APIVersion="Acrobat:21.7.0" 
            xfa:spec="2.0.2">
            <p>
                <span style="font-size:10.0pt"><i>リッチ</i>テキスト</span>
            </p>
        </body>
    </value-richtext>
```

## コメント

`<annots>` 内にコメントブロックを配置する。

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
        <annots>
            ...
        </annots>
        <f href="xxx.pdf"/>
        <ids original="D44B3069C43280202DC5423980241179" 
            modified="B45F09C7D1006DEBF9E6EC5B88B0E834"/>
    </xfdf>
```

* コメントブロックは`<annots>`下に配置する。主なコメントブロックには次の種類がある。
  * テキストに修飾
    * ハイライト `highlight`
    * 下線 `underline`
    * 波下線 `squiggly`
    * 取り消し線 `strikeout`
  * テキストの校正
    * 挿入テキスト `caret`
  * テキスト
    * ノート注釈 `text`
    * テキスト注釈・テキストボックス・引き出し線付きテキストボックス `freetext`
  * 図形
    * 線・矢印線 `line`
    * 四角形 `square`
    * 円・楕円 `circle`
    * 多角形 `polygon`
    * 折れ線 `polyline`
    * 自由曲線 `ink`
  * スタンプ `stamp`
  * ポップアップノート `popup`
  * その他 `fileattachiment`,`sound`,`link`,`redact`,`projection`,`movie`,
    `widget`,`screen`,`printmark`,`trapnet`,`richmedia`,`3d`,`watermark`

## コメントブロックの共通属性

コメントブロックで共通して使用される属性には、以下がある。

* `color` 色(#rrggbb) ※省略時は枠なし
* `opacity` 透明度(0.0～1.0,小数点表記) ※省略時は不透明(=1.0)
* `date`, `creationdate` 日付(省略可)
  ※`date`を省略すると更新日が`不明`表示になるので省略しないほうが良い
* `flags` フラグ(複数ある場合はカンマ区切り)
  * `hidden` 非表示指定
  * `print` 印刷対象
  * `locked` ロック指定
  * `nozoom`
  * `norotate`
* `name` コメントブロックの名前(省略可)
* `page` コメントブロックを表示するページ
* `rect` コメントブロックを表示する領域全体範囲
* `subject` コメントブロックのサブジェクト(省略可)
* `title` コメントブロックのタイトル・作成者名(省略可)
* 各ブロックにはポップアップノートを設けることができる。 `<popup ...>`

## 文字列修飾(ハイライト,アンダーライン,取り消し線)

* ハイライトは、`<highlight ...>` で指定する。
* 下線は、`<underline ...>` で指定する。
* 波下線は、`<squiggly ...>`で指定する。
* 取り消し線は、`<strikeout ...>`で指定する。
* `coords`属性で指定する範囲にテキストがあるとものとして修飾する。\
  値は "x1,y1,x2,y2,x3,y3,x4,y4" と座標をカンマ区切りで表す。\
  (x1,y1)-(x2,y2)の直線と(x3,y3)-(x4,y4)の直線の間を1つのテキスト範囲とする。\
  続けて複数指定することにより複数行を対象に出来る
* `IT` 種別表示を変更する
  * `IT="HighlightNote"` ハイライトノート

## キャレット

文字間に対してコメントする。校正に使用する。
校正は、基本的には「取り消し」「挿入」「置換」を明示する。\
「取り消し」は取り消し線を使用する。\
「挿入」はキャレットにテキストを入れる。\
「置換」は、「取り消し」と「挿入」を並べたものになる。

* `IT` 種別表示を変更する
  * `IT="Replace"` 置換テキスト
  * `IT="StrikeOutTextEdit"` 取り消し線
* `fringe`
* `content-richtext`

## ノート注釈

ノート注釈は、アイコンを配置し、アイコンを選択するとノートを表示する。
ノート注釈は、 `<text ...>` を使用する。

```xml
    <text 
        color="#FFD100" 
        icon="Comment" 
        page="0" 
        rect="100.000000,76.000000,124.000000,100.000000" >
        <contents-richtext>
            <body xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xfa="http://www.xfa.org/schema/xfa-data/1.0/" 
                xfa:APIVersion="Acrobat:21.7.0" xfa:spec="2.0.2">
                <p>ノート</p>
            </body>
        </contents-richtext>
    </text>
```

* `icon` アイコンを指定する
  * 省略時 ノート
  * `"Check"` チェックマーク
  * `icon="Checkmark"` テキストを挿入
  * `icon="Circle"` 円形
  * `icon="Comment"` コメント
  * `icon="Cross"` 十字型
  * `icon="CrossHairs"` 十字アイコン
  * `icon="Help"` ヘルプ
  * `icon="Insert"` テキストを挿入
  * `icon="Key"` キー
  * `icon="NewParagraph"` 新規段落
  * `icon="Paragraph"` 段落
  * `icon="RightArrow"` 右向き矢印
  * `icon="RightPointer"` 右向きポインター
  * `icon="Star"` 星形
  * `icon="UpArrow"` 上向き矢印
  * `icon="UpLeftArrow"` 左上向き矢印
* `rect` アイコンの表示領域を指定する
* 選択し表示するテキスト文字列は `<contents-richtext>` に指定する

## テキスト注釈・テキストボックス

自由に配置できるテキストには、 `<freetext ...>` を使用する。\
基本はテキストボックス(枠で囲んだテキスト)であるが、 `width="0.0"` を指定することにより枠なしのテキストとなる。

```xml
    <freetext 
        width="0.000000" 
        IT="FreeTextTypewriter" 
        page="0" 
        rect="128.010803,646.210144,176.020813,662.470154" >
        <contents-richtext>
            <body xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xfa="http://www.xfa.org/schema/xfa-data/1.0/" 
                xfa:APIVersion="Acrobat:21.7.0" xfa:spec="2.0.2"
                style="font-size:12.0pt;text-align:left;color:#000000;
                    font-weight:normal;font-style:normal;
                    font-family:KozMinPr6N-Regular;font-stretch:normal">
                <p>テキスト</p>
            </body>
        </contents-richtext>
        <defaultappearance>16.25 TL /MSGothic 12 Tf</defaultappearance>
        <defaultstyle>
            font: KozMinPr6N-Regular 12.0pt;font-stretch:Normal; text-align:left; color:#000000 
        </defaultstyle>
    </freetext>
```

* `width` 枠の幅(単位はポイント) ※省略時は1ポイント幅
* `IT` 種別表示を変更する
  * `IT="FreeTextTypewriter"` タイプライタ

## テキスト文字列

テキストは、コメントブロックの下位に `<contents-richtext ...>` で指定する。

```xml
    <contents-richtext>
        <body xmlns="http://www.w3.org/1999/xhtml"
            xmlns:xfa="http://www.xfa.org/schema/xfa-data/1.0/" 
            xfa:APIVersion="Acrobat:21.7.0" 
            xfa:spec="2.0.2" 
            style="font-size:12.0pt;text-align:left;color:#000000;
            font-weight:normal;font-style:normal;font-family:KozMinPr6N-Regular;
            font-stretch:normal">
            <p dir="ltr">
                <span style="line-height:16.2pt;font-family:'Kozuka Mincho Pr6N R'">テキスト注釈</span>
            </p>
        </body>
    </contents-richtext>
```

## 図形属性

* `width` 線幅(単位はポイント) ※省略時は1ポイント幅
* `style` 線のスタイル指定
  * `"dash"` 破線の指定
  * `"cloudy"` 雲形の指定
* `dashes` 破線の間隔 (`width`>2 でいないと正常に認識しない)
  * dashes="2.000000,2.000000"
  * dashes="3.000000,3.000000"
  * dashes="4.000000,4.000000"
  * dashes="4.000000,3.000000,2.000000,3.000000"
  * dashes="4.000000,3.000000,16.000000,3.000000"
  * dashes="8.000000,4.000000,4.000000,4.000000"
* `intensity` 雲形の間隔
  * intensity="1.000000"
  * intensity="2.000000"
* `inter-color` 領域内の色(#rrggbb) ※省略時は領域色なし
* `fringe` フリンジ(省略可) 通常は `rect` の領域の外側の領域幅

## 線・矢印線

線に描く曲線は、 `<line ...>` を使用する。

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

* `start` 開始座標
* `end` 終了座標

矢印を付けるには、以下を追加。

* `head` 開始位置の矢印タイプ (不要なら省略可)
* `tail` 終了位置の矢印タイプ (不要なら省略可)

矢印のタイプ：

* `"None"` 矢印なし
* `"OpenArrow"` 開いた矢印
* `"CloseArrow"` 閉じた矢印
* `"ROpenArrow"` 開いた矢印(内向き)
* `"RCloseArrow"` 閉じた矢印(内向き)
* `"Butt"` 突合わせ
* `"Diamond"` ひし形
* `"Circle"` 円形
* `"Square"` 四角
* `"Slash"` スラッシュ

種別表示を変更する

* `IT="LineArrow"` 「矢印」表示
* `IT="PolygonCloud"` 「雲形」表示

## 四角形

四角形は、`<square ...>`を使用する。

```xml
    <square 
        color="#E52237" 
        page="0" 
        fringe="0.500000,0.500000,0.500000,0.500000" 
        rect="346.694763,238.014526,400.188385,279.535950" >
    </square>
```

## 円・楕円

円形は、`<circle ...>`を使用する。

```xml
    <circle 
        color="#E52237" 
        page="0" 
        fringe="0.500000,0.500000,0.500000,0.500000" 
        rect="447.998260,225.121338,503.333771,266.642761" >
    </circle>
```

## 多角形

多角形は、`<polygon ...>`を使用する。
頂点を`<vertices>`に並べる。

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

## 折れ線

折れ線は、`<polyline ...>`を使用する。
頂点を`<vertices>`に並べる。

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

## 自由曲線

自由に描く曲線は、 `<ink ...>` を使用する。
コメントブロックの下位に `<inkList>`、さらに下位に `<gesture>` に曲線の通過点を並べる。

```xml
    <inklist>
        <gesture>
            121.564209,339.818024;
            122.485153,341.659912;
            124.327042,344.422729;
            ...
            197.081390,337.055206
        </gesture>
    </inklist>
```

## スタンプ

スタンプは、 `<stamp ...>` を使用する。
スタンプは、アイコンの絵を表示する。

```xml
    <stamp
        color=”#FF0000”
        icon=”SBApproved” 
        page=”0” 
        rect=”54.987381,671.039063,216.486893,718.539551” >
    </stamp>
```

* `icon` にアイコンの名前
  * `SBApproved` 承認ボタン
  * ... いろいろ

## ポップアップノート

コメントブロックはポップアップノートを持つことができる。
各ブロックの下位に `<popup ...>` を配置する。

* `flags` フラグ(複数ある場合はカンマ区切り)
  * `print`
  * `nozoom`
  * `norotate`
* `open` 表示状態(`no`:要求すると開く、`yes`:最初から開いている)
* `page` 表示するページ
* `rect` 表示する範囲

## 座標

座標は、各ページの左下を原点として第一象限配置する。

## 用紙

|paper| paper size(mm) | size(72dpi)     | size(96dpi)     |
|:---:|----------------|-----------------|-----------------|
| A4  | 210mm x 297mm  |  595pt x 842pt  |  794pt x 1123pt |
| A3  | 297mm x 420mm  |  842pt x 1191pt | 1123pt x 1588pt |
| A2  | 420mm x 594mm  | 1191pt x 1684pt | 1588pt x 2246pt |
| A1  | 594mm x 841mm  | 1684pt x 2384pt | 2246pt x 3180pt |
| A0  | 841mm x 1189mm | 2384pt x 3370pt | 3180pt x 4496pt |

### 用紙サイズ

A0版の定義：

* `縦[m]*横[m] = 1`  ※面積=1m^2
* `縦[m]/横[m] = sqrt(2)` ※黄金比

`A版サイズ計算 縦[mm] = floor(1000/2^((2*n-1)/4)+0.2)`  
`A版サイズ計算 横[mm] = floor(1000/2^((2*n+1)/4)+0.2)`  
n=0,1,2,3,4,... ※サイズ序数

### 72dpi の場合(Web表示関係標準, pdf)

単位はポイント(pt) 72dpi, 1inch=25.4mm, 1inch=72pt  
⇒ pt(x)=x*72/25.4

### 96dpi の場合(表示関係標準, Windowsの場合)

単位はポイント(pt) 96dpi, 1inch=25.4mm, 1inch=96pt  
⇒ pt(x)=x*96/25.4

96dpi = 72dpi * 4/3

## 日付

`date`属性と`createdate`属性は、日付を指定する。\
`2021年12月19日 19時16分24秒 +09:00`は、`"D:20211219191624+09'00'"` で表す。

## 状態

`statemodel` で状態モデルを指定し、`state`に状態を指定する。

ステータスは`Review`モデルを使用する

* `statemodel="Review"`
  * `state="None"` なし
  * `state="Accepted"` 承認
  * `state="Cancelled"` キャンセル
  * `state="Completed"` 完了
  * `state="Rejected"` 却下

チェックマークは`Marked`モデルを使用する

* `statemodel="Marked"`
  * `state="Marked"` マーク設定
  * `state="Unmarked"` マーク解除

## リプライ

コメントブロックは`inreplyto`属性で指定した名前のコメントブロックへのリプライとして扱う。

```xml
    <text 
        name="65ba4fde-e993-45ab-8176-1f60177b948a" >
        <contents-richtext>
            テキスト
        </contents-richtext>
    </text>

    <text 
        inreplyto="65ba4fde-e993-45ab-8176-1f60177b948a" 
        name="d3a51b32-240c-444a-94a9-ac97ccb23471" >
        <contents-richtext>
            リプライテキスト
        </contents-richtext>
    </text>
```

* `replyType`
  * 省略時は返信
  * `replyType="group"` グループ化(複数のコメントブロックを1つとして扱う指定)
