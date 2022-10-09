# XFDFファイルフォーマット(注釈)

`<annots>` の子要素として注釈要素を配置する。

```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <xfdf xmlns="http://ns.adobe.com/xfdf/" xml:space="preserve">
        <annots>
            ...
        </annots>
        ...
    </xfdf>
```

主な注釈要素には次の種類がある。

* [テキストの校正](format_xfdf_proof.md)
  * テキストに修飾
    * ハイライト `<highlight>`
    * 下線 `<underline>`
    * 波下線 `<squiggly>`
    * 取り消し線 `<strikeout>`
  * 文字間に修飾
    * 挿入テキスト `<caret>`
* [テキスト](format_xfdf_text.md)
  * ノート注釈 `<text>`
  * テキスト注釈・テキストボックス・引き出し線付きテキストボックス `<freetext>`
* [図形](format_xfdf_figure.md)
  * 線・矢印線 `<line>`
  * 四角形 `<square>`
  * 円・楕円 `<circle>`
  * 多角形 `<polygon>`
  * 折れ線 `<polyline>`
  * 自由曲線 `<ink>`
* [スタンプ](format_xfdf_stamp.md) `<stamp>`
* [埋め込みオブジェクト](format_xfdf_embd.md)
  * 添付ファイル `<fileattachiment>`
  * サウンドデータ `<sound>`
* その他  
  `link`, `redact`,  
  `projection`, `movie`, `widget`, `screen`,  
  `printmark`, `trapnet`, `richmedia`, `3d`, `watermark`

---

## ポップアップノート

* ポップアップノート `<popup>`

注釈要素はポップアップノートを持つことができる。
各注釈要素の子要素として `<popup ...>` を配置する。

* `flags` フラグ(複数ある場合はカンマ区切り)
  * `print`
  * `nozoom`
  * `norotate`
* `open` 表示状態(`no`:要求すると開く、`yes`:最初から開いている)
* `page` 表示するページ
* `rect` 表示する範囲

---

## リプライ

注釈要素は`inreplyto`属性で指定した名前の注釈要素へのリプライとして扱う。

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
  * `replyType="group"` グループ化(複数の注釈要素を1つとして扱う指定)

---

## 状態

注釈要素は状態を表示出来る。主にリプライ機能と併用する。  
`statemodel` 属性で状態モデルを指定し、`state`属性に状態を指定する。

### ステータス機能

`Review`モデルを使用する

* `statemodel="Review"`
  * `state="None"` なし
  * `state="Accepted"` 承認
  * `state="Cancelled"` キャンセル
  * `state="Completed"` 完了
  * `state="Rejected"` 却下

### チェックマーク機能

`Marked`モデルを使用する

* `statemodel="Marked"`
  * `state="Marked"` マーク設定
  * `state="Unmarked"` マーク解除

---

## 日付

`date`属性と`createdate`属性は、日付を指定する。  
`2021年12月19日 19時16分24秒 +09:00`は、`"D:20211219191624+09'00'"` で表す。

---

## コンテンツ

コンテンツはテキスト文章を持つ。コンテンツは2種類ある。

* コンテンツ `contents`  
  内包するデータは使用目的によって異なる。  
  テキストが目的ならば、特別な修飾されていない文字列を指定する。
* リッチテキストのコンテンツ `contents-richtext`  
  フォント指定や、文字色指定など簡単な表現を行ったテキストを指定する。  
  基本的には、XHTML のサブセットを使用する。
