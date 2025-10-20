#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#show: metropolis-theme.with(aspect-ratio: "16-9", footer: utils.display-current-heading(level: 1), config-info(
  title: [技術同人誌の紹介],
  subtitle: [],
  author: [宇佐見公輔],
  date: datetime(year: 2025, month: 10, day: 7),
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
  grid(
    rows: 2,
    gutter: 1em,
    [
      === 宇佐見公輔（うさみこうすけ）
      - iOSテックリード（登壇・執筆系）
      - iOSDCパンフ記事採択（6年連続）
      - 月刊I/O記事寄稿（iOS/パズル等6本）
    ],
    rect(stroke: gray, image("images/iOSDC_RealityKit.png", width: 87%)),
  ),
  rect(stroke: gray, image("images/4868m.jpg")),
)

= 技術同人誌とは

== 技術同人誌とは

- 同人：同じ趣味や志を持つ人たち
- 同人誌：「同人」が自分で制作して頒布する書籍
- 技術同人誌：「同人誌」のうち技術をテーマにしたもの

ひとことで言えば「技術オタクが自分の趣味で作った本」

== 技術同人誌と商業誌

商業誌＝出版社が制作して出版する書籍。つまり普通の書籍のこと。同人誌と区別するための用語。

- 社会的な信頼度は、商業誌が高い
  - 出版社が出している＝箔がつく
  - 書店などで流通する

- 技術的な信頼度は、技術同人誌も商業誌も変わらない
  - 著者の技量によるところが大きい
  - 出版社や編集者が専門知識を持っているわけではない

== 技術同人誌の特徴

技術同人誌の良さがある。

- 商業誌は、出版社で企画が通らなければ世に出ない
  - 売れる見込みを考えて企画する
- 技術同人誌は、著者の情熱があれば世に出せる
  - 売れるかどうかではなく、自分が書けば始まる

ただし、ハードルの高さもある。

- 技術同人誌はすべて自分でやらなくてはならない
  - 本を制作する方法から調べる必要がある
  - 印刷費や頒布に関する諸費用は自分で持つ必要がある

== ゆめみ大技林

#grid(
  columns: 2,
  gutter: 1em,
  [
    参入のハードルを下げるための試みとして始めたのが、「ゆめみ大技林」。

    - 有志が集まって制作する合同誌
    - 自分の記事が本になる
    - 同人誌制作のノウハウが得られる
  ],
  rect(stroke: gray, image("images/daigirin25.png")),
)

= 技術同人誌のイベント

== 技術同人誌のイベント

もともとは同人誌のジャンルのひとつだったので、コミケなどのイベントで頒布されていた。

しかし現在は、技術書オンリーのイベントがある。

- 技術書典（ぎじゅつしょてん）
- 技書博（ぎしょはく）

== 技術書典

#grid(
  columns: 2,
  gutter: 1em,
  [
    - 第1回が2016年に開催
    - 技術書オンリーでは最大規模
    - ゆめみがスポンサー出展
    - 第19回
      - 2025年11月16日（池袋）
      - 15日〜30日（オンライン）
  ],
  rect(stroke: gray, image("images/tbf19.jpg")),
)

== 技書博

#grid(
  columns: 2,
  gutter: 1em,
  [
    - 第1回が2019年に開催
    - 商業出版社の参加が多い
    - ゆめみがスポンサー出展
    - 第12回
      - 2025年10月26日（大宮）
  ],
  rect(stroke: gray, image("images/gishohaku12.png")),
)

= 個人活動の紹介

== 個人サークル

#grid(
  columns: 2,
  gutter: 1em,
  [
    - 個人でサークル出展している
    - これまでに7冊の技術同人誌を制作
  ],
  rect(stroke: gray, image("images/TypeD4Lab.png")),
)


== Swift Testing でユニットテストを書く

#grid(
  columns: 2,
  gutter: 1em,
  [
    - 2025年5月発行
    - Swift言語の新しい単体テストフレームワークの解説
    - この前後にも各種の勉強会に登壇して、Swift Testingについて話した
  ],
  rect(stroke: gray, image("images/BookTesting.png")),
)

== パズルキューブSquare-1で遊ぼう

#grid(
  columns: 2,
  gutter: 1em,
  [
    - 2024年4月発行
    - ルービックキューブ風のパズルの解説
    - この本が月刊I/O編集者の目に留まって、雑誌への記事寄稿につながった
  ],
  rect(stroke: gray, image("images/BookSquareOne.png")),
)

= まとめ

== まとめ

- 技術同人誌とは
  - 参入のハードルを下げる、ゆめみ大技林
- 技術同人誌のイベント
  - 技術書典
  - 技書博
- 個人活動の紹介

みなさんも本を書いてみませんか。

