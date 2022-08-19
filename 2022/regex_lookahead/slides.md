---
theme: apple-basic
canvasWidth: 720
highlighter: shiki
layout: intro
---

# 正規表現の<br>少し進んだ機能

<div class="absolute bottom-10">
  <span class="font-700">宇佐見公輔 / 株式会社ゆめみ</span>
</div>

---

# 自己紹介

* 宇佐見公輔 / 株式会社ゆめみ / iOSテックリード
* 大阪在住、最寄のゆめみオフィスは京都（まだ物理出社してないが）
* 来月のiOSDCにパンフレット記事寄稿、トーク登壇予定
* 来月の技術書典に出展予定

---

# 正規表現を再勉強中

* Swiftで正規表現が言語組み込みになる
* この機会に、正規表現を再勉強

<mdi-arrow-down-thick class="text-2xl mx-50" />

* 意外と知らない機能がいろいろあった
* 例：名前付きキャプチャ、後方参照

<mdi-arrow-down-thick class="text-2xl mx-50" />

* 書いた：[Swift Regexでキャプチャや名前付きキャプチャを使う - Qiita](https://qiita.com/usamik26/items/5a13d12ffc332ddf0512)

---

# 正規表現の基本

* 文字列のパターンマッチ
* 部分文字列の抽出（キャプチャ）

<div class="container flex gap-4">
  <div><img src="/regex.png"  class="h-50"/></div>
  <div><img src="/regex_capture.png"  class="h-50"/></div>
</div>

---

# 位置へのマッチ

* アンカー：「文字列」でなく「位置」にマッチする
* 長さ0の文字列にマッチすると考えて、ゼロ幅アサーションとも呼ばれる
* `^`（先頭）`$`（末尾）`\b`（単語の境界）など

<div class="container flex gap-4">
  <div><img src="/anchor.png"  class="h-50"/></div>
</div>

---

# 少し進んだ機能の紹介

* 先読み（lookahead）
* 後読み（lookbehind）

---

# 先読み

先読み（lookahead）は、位置にマッチする記法の一種で、位置の指定に正規表現が使える。
`(?=` と `)` で囲む。

```
a(?=..d)
→ 「a」の次に「任意の2文字＋d」が来る場合に限り、「a」にマッチする
```

<div class="container flex gap-4">
  <div><img src="/lookahead.png"  class="h-50"/></div>
</div>

---

# 後読み

* `(?=regex)` : 先読み。次に `regex` がくる位置にマッチ。
* `(?<=regex)` : 後読み。前に `regex` がくる位置にマッチ。

<div class="container flex gap-4">
  <div><img src="/lookbehind.png"  class="h-55"/></div>
</div>

---

# 否定先読み・否定後読み

* `(?!regex)` : 否定先読み。次に `regex` がこない位置にマッチ。
* `(?<!regex)` : 否定後読み。前に `regex` がこない位置にマッチ。

<div class="container flex gap-4">
  <div><img src="/lookahead_neg.png"  class="h-55"/></div>
</div>

---

# 先読みが便利な場合(1)

* 複数の正規表現すべてにマッチするか

<div class="container flex gap-4">
  <div><img src="/lookahead_and.png"  class="h-65"/></div>
</div>

---

# 先読みが便利な場合(2)

* 数値の3桁ごとにカンマを挿入するコード

<div class="container flex gap-4">
  <div><img src="/lookahead_replace.png"  class="h-65"/></div>
  <div class="self-center">→ これ、どうなってるの？</div>
</div>

---

# 先読みが便利な場合(2) 解説

<div class="container flex gap-4">
  <div><img src="/lookahead_replace_note.png"  class="h-75"/></div>
</div>





---

# 書籍

<div class="container flex gap-4">
  <div><img src="https://image.gihyo.co.jp/assets/images/gdp/2015/978-4-7741-7326-9.jpg"  class="h-60"/></div>
  <div><img src="https://www.oreilly.co.jp/books/images/picture_large978-4-87311-359-3.jpeg"  class="h-60"/></div>
  <div><img src="https://www.oreilly.co.jp/books/images/picture_large978-4-87311-450-7.jpeg"  class="h-60"/></div>
</div>

---

# 便利ツール

<div class="container flex gap-4">
  <div><img src="/expressions.png"  class="h-55"/></div>
  <div><img src="/coderunner.png"  class="h-55"/></div>
</div>
