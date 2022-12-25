# PDF 解析

## 基本構造

PDFファイルの1行目に `%PDF-x.x` でバージョン付きシグネチャを指定する。

2行目は無くても動作するが、nバイトのバイナリ値を配置(`****`位置)することでテキストエディタが認識しないようにする。ファイル最終行は `%%EOF` とする。 `%%EOF` の前には `startxref` 行があり次の行にクロスリファレンステーブルのオフセットを指定する。

```
%PDF-x.x
****

...

startxref
0
%%EOF
```

## バージョン

バージョンは1行目とカタログオブジェクトに指定する。

1.7

## オブジェクト

オブジェクトは `obj` と `endobj` で括る。 `obj` の前にオブジェクト番号と世代番号が付く。世代番号は通常 0 を指定する。

```
0 0 obj

...

endobj
```

## オブジェクトの中身

オブジェクトの中身には、

* 固定値( `true`, `false`, `null` )
* 整数値( `123` )
* 浮動少数値( `.123` )
* 文字列(括弧で囲む `(ABC)` )
* HEX文字列( `<12345678>` )
* 名前( `/Abc` )
* オペレータ( `abc` )
* リスト( `[1 2 3]` )
* マップ( `<</A 1 /B 2 /C 3>>` )
* コメント行( `%...` )
* ストリーム

## ストリーム

ストリームはまとまったデータを表す。

ストリームは `stream` と `endstream` で括る。 `stream` の前にマップを付け、マップに `/Length` のストリームの中身のバイト数を指定する。

ストリームをアッシュ苦闘する場合は、フィルタをマップに追加する。
`/Filter` がある場合はストリームの中身をデコードする。値が `/FlateDecode` ならば、Deflate すると中身を見ることができる。

```
<<
/Length 123
/Filter /FlateDecode
>>
stream
...
endstream
```

/Length integer(必須)ストリーム(Stream)に記載されたデータのバイト数

/Filter name/array(オプション)データが圧縮された場合のフィルター名
複数フィルターの場合はarrayで記載

/DecodeParms dictionary/array(オプション)フィルターのパラメータを指定

## クロスリファレンステーブル

クロスリファレンステーブル、およびトレイラーディクショナリがあり、

* `xref` , `trailer` オペレータを使用する方法と、
* ストリームにする方法

がある。

オペレータを使用する方法
```
xref
...
trailer
<<
/Info 5 0 R
/Root 1 0 R
/Size 8
/ID [<1775615b6d180ff72f4473d56aaa72bf>
     <a5902498ce444a8aa67f819e1023432d>]
>>
```

/Size (必須) オブジェクトの数、クロスリファレンステーブルのオブジェクトの数と同じでなければならない。

/Root (必須) ドキュメントオブジェクト

## トレイラー

/Size クロスリファレンス・テーブルのエントリ数

/Root カタログ(Catalog)ディクショナリ

/Prev 以前のクロスリファレンス・テーブルの位置を示すオフセット値

/Info 文書情報(Document Information)ディクショナリ

/ID 2つのバイトストリング（「<」と「>」で囲まれた）で構成されたファイル識別子

/Encrypt 暗号化ディクショナリ

## カタログ(Catrog)

```
1 0 obj
<<
  /Type /Catalog
  /Pages 2 0 R
>>
```

### カタログ(Catrog)ディクショナリ

|キー|タイプ|必須|値|
|----|-----|------|--|
|/Type|name|必須|`/Catalog` を指定|
|/Pages|dictionary|必須|ページツリー(Page Tree)|
|/PageLayout|name||文書を表示したときのレイアウトを指定|
|/PageMode|name||文書を表示した時の全体構成を指定|
|/Version|name||PDFファイルのヘッダー(Header)に記載されたバージョンより古い場合は、無視。PDF文書が更新され更新前のバージョンより新しくなった場合は、ここで指定|
|Outlines|dictionary||アウトライン(Outlines)のルートへの参照を指定。アウトラインは、文書の概要を階層で示した情報|
|Threads|array||Articlesノード オブジェクトへの参照|
|OpenAction|array/dictionary||文書を開くときの動作を指定します。  arrayの場合はDestinationsを表し、dictionaryの場合はActionsを表します。|
|AcroForm|dictionary||Interactive Formディクショナリ(入力フォーム)を指定|
|Metadata|streams||Metadata Streamsを表すインダイレクトオブジェクトへの参照|

### /PageLayout の値

|名前|内容|
|----|----|
|/SinglePage|１ページを表示|
|/OneColumn|１っのカラムでページを表示|
|/TwoColumnLeft|２っのカラムでページを表示、奇数ページが左カラム|
|/TwoColumnRight|２っのカラムでページを表示、奇数ページが右カラム|
|/TwoPageLeft|２ページを同時に表示、奇数ページが左側|
|/TwoPageRight|２ページを同時に表示、奇数ページが右側|
|既定値は、/SinglePageです。|

### /PageMode の値

|名前|内容|
|----|----|
|UseNone|しおり、サムネール画像を非表示|
|UseOutlines|しおりを表示|
|UseThumbs|サムネール画像を表示|
|FullScreen|フルスクリーン・モード表示|
|UseOC|オプショナル コントロール パネル表示|
|UseAttachements|アタッチメント パネル表示|
既定値は、UseNoneです。


## ページツリー(PageTree)

```
2 0 obj
  << /Type /Pages
    /Kids [ 3 0 R
            4 0 R
          ]
    /Count 2
  >>
endobj

3 0 obj
  << /Type /Page
    ･･･このページの属性を記述する追加の項目･･･
  >>
endobj

4 0 obj
  << /Type /Page
    ･･･このページの属性を記述する追加の項目･･･
  >>
endobj
```

### ページツリー(PageTree) ディクショナリ

|キー|タイプ|必須|値|
|----|-----|------|--|
|/Type|name|必須|"Pages"を指定|
|/Parent|dictionary|必須|親オブジェクトへの参照|
|/Kids|array|必須|子ノード オブジェクトへの参照 子ノードは、ページ(Page)または、ページツリー(Page Tree)オブジェクト|
|/Count|integer|必須|このPage Treeの子孫であるPageオブジェクトの数|

## ページ(Page)

```
3 0 obj
  << /Type /Page
    /Parent 2 0 R
    /MediaBox [ 0 0 612 792 ]
    /Resources << /Font << /F3 6 0 R
                           /F5 7 0 R
                           /F7 8 0 R
                        >>
                  /ProcSet [ /PDF ]
               >>
    /Contents 10 0 R
    /Thumb 11 0 R
    /Annots [ 12 0 R
              13 0 R
            ]
  >>
endobj
```

### ページ(Page) ディクショナリ

|キー|タイプ|必須|値|
|----|-----|------|--|
|/Type|name|必須|"Page"を指定|
|/Parent|dictionary|必須|直接の親オブジェクト|
|/Resources|dictionary|必須|このページで必要とするリソース|
|/MediaBox|四角形|必須|表示または印刷される際のページのサイズ [xs ys xe ye]<br>A4: [0 0 612 792]<br>A3: [0 0 792 1224]<br>A2: [0 0 1224 1584]<br>A3: [0 0 1584 2448]|
|/Contents|stream/array||このページに表示されるべき内容(Content Stream Content Streamではグラフィック、画像、テキストなどが定義|
|/Rotate|integer||表示または印刷される際のページの回転角度<br>0: 0度<br>90: 90度<br>180: 180度<br>270: 270度|
|/Thumb|stream||このページのサムネール画像のストリーム オブジェクトを指定|
|/Annots|array||このページに関連するアノテーションを指定|
|/UserUnit|number||ページ解像度を指定倍 既定値は1.0 1単位は1/72インチ|

## コンテンツ(Contents)

```
10 0 obj
<< /Length 123 >>
stream

...

endstream
endobj
```
