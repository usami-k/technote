#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#show: metropolis-theme.with(aspect-ratio: "16-9", footer: utils.display-current-heading(level: 1), config-info(
  title: [組版ソフトウェアTypst],
  subtitle: [],
  author: [宇佐見公輔],
  date: datetime(year: 2025, month: 11, day: 7),
  logo: image("images/Profile_NFT.jpeg", height: 35%),
))
#set text(font: ("DejaVu Sans", "BIZ UDGothic"), size: 24pt)
#show raw: set text(font: ("0xProto", "BIZ UDGothic"), size: 22pt)
#show raw.where(block: true): set text(font: ("0xProto", "BIZ UDGothic"), size: 20pt)
#show raw.where(block: true): set block(fill: rgb("#f3ede6"), inset: 1em)
#show link: it => underline(text(blue, it))
#show math.equation: set text(font: ("DejaVu Math TeX Gyre", "BIZ UDGothic"), size: 24pt)
#title-slide()

== 自己紹介

#grid(
  columns: 2,
  gutter: 1em,
  [
    === 宇佐見公輔（うさみこうすけ）
    - iOSテックリード
    - 先月は技術同人誌の話をしました

    === 最近の寄稿 : 月刊I/O 2025年11月号
    - 「パズルを解くためのコミュテーター」
      ルービックキューブを自力で解くための考えかた
  ],
  rect(stroke: gray, image("images/4880m.jpg")),
)

== 新刊紹介

#grid(
  columns: 2,
  gutter: 1em,
  [
    技術同人誌の新刊（個人では8冊目）

    === 『組版ソフトウェアTypstを活用しよう』
    - 10/26（日）技書博12に新刊出展
    - 11/16（日）技術書典19にも出展予定
  ],
  rect(stroke: gray, image("images/BookTypst.png")),
)

= 組版（くみはん）とは

== 組版（くみはん）

#grid(
  columns: 2,
  gutter: 1em,
  [
    活版印刷において、活字を組んで印刷用の版を作ること。
  ],
  image("images/d174b388-5694-4937-a0e3-07c5df17fc2d.jpg"),
)

#text(size: 13pt)[
  出典：「福井発でいこう！福井新聞にてDX/シビックテック講演、360度写真をドロップするだけで表示するVRツール追加」
  https://fukuno.jig.jp/3282
]

== 現在の組版

現在では、印刷用のデジタルデータを作成することも組版とよぶ。

=== 主な組版ソフトウェア

#grid(
  columns: 3,
  gutter: 1em,
  align: top,
  [
    - Adobe InDesign
    - Affinity
  ],
  [
    - LaTeX
    - Re:VIEW
  ],
  [
    - Vivliostyle
    - Typst
  ],
)

= 組版ソフトウェア

== GUIツール

=== Adobe InDesign

- 商業出版におけるデファクトスタンダード

=== Affinity

- 以前のAffinity Publisherが組版機能
- 統合され無償化されたAffinity（by Canva）も組版機能を持つ

== LaTeX

- 技術文書や学術論文の組版におけるデファクトスタンダード
- 数式の組版に強み
  - 数式のテキスト表現として、LaTeX記法が事実上の標準

== Re:VIEW

- 日本発の組版ソフトウェア
- 商業出版や同人誌で多く使われている
  - 業界のノウハウを少ない設定で利用できるのが強み
- バックエンドにInDesignやLaTeXなどが使える

== Vivliostyle

- CSS組版
  - 組版にHTML/CSSの知識が活かせる
- Markdown記法が使える

=== 補足：ゆめみ大技林で採用

上記の特徴が、メンバーの共著活動にマッチ。

== Typst

- 2023年にオープンソースでリリースされた新しいソフト
- 特に技術文書や学術論文の組版で注目されている
  - LaTeXの代替となりうる

= Typstの特徴

== 高速な出力生成

- VSCodeでのプレビューやPDF生成が高速
  - 従来の組版ソフトウェアの欠点を克服
  - 組版結果をリアルタイムに確認できる

== 簡潔な記法

- 独自記法ではあるが、Markdownに慣れていればすぐ覚えられる
- 数式もLaTeXより簡潔に書ける

== さまざまな出力

- レポート・書籍
  - 今回のTypst本もTypstで作成
- プレゼンスライド
  - このスライドもTypstで作成
- 学会ポスター
  - A0サイズのポスター
  - 昨年のカンファレンスのポスターセッションに利用

= まとめ

== まとめ

#grid(
  columns: 2,
  gutter: 1em,
  [
    - Typstは新しいソフトで注目されている
    - LaTeXの代替となりうる
    - さまざまな制作に活用できる
  ],
  rect(stroke: gray, image("images/BookTypst.png")),
)
