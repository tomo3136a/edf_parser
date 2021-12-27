# XFDFファイルフォーマット

## 拡張子

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

* `<f href="...">` および `<ids original="..." modified="...">` 元のpdfファイルへのリンク情報。
  無くてもよい
* rootは、`<xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">`とする
* コメントブロックは`<annots>`下に配置する。コメントブロックには次の種類がある。
  * ハイライト
  * 四角形
  * そのほかいろいろ
* コメントブロックの共通属性
  * `width` 枠の幅(単位はポイント) ※省略時は1ポイント幅
  * `color` 枠の色(#rrggbb) ※省略時は枠なし
  * `opacity` 透明度(0～1,小数点表記) ※省略時は不透明
  * `inter-color` 領域内の色(#rrggbb) ※省略時は領域色なし
  * `date`,`creationdate` 日付(省略可)
    ※`date`を省略すると更新日が`不明`表示になるので省略しないほうが良い
  * `flags` フラグ(複数ある場合はカンマ区切り)
    * `print` 印刷対象
    * `nozoom`
    * `norotate`
  * `name` ブロックの名前(省略可)
  * `page` 表示するページ
  * `rect` 表示する範囲
  * `fringe` フリンジ(省略可) 通常は各項 `width` の領域分設ける
  * `subject` ブロックのサブジェクト(省略可)
  * `title` タイトル・作成者名(省略可)
* ハイライトは、`<highlight ...>` で指定する。
* 四角形は`<square ...>`で指定する。
* 各ブロックにはポップアップノートを設けることができる。 `<popup ...>`
  * `flags` フラグ(複数ある場合はカンマ区切り)
    * `print`
    * `nozoom`
    * `norotate`
  * `open` 表示状態(`no`:要求すると開く、`yes`:最初から開いている)
  * `page` 表示するページ
  * `rect` 表示する範囲
