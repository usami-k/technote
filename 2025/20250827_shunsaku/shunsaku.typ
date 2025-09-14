#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#show: metropolis-theme.with(aspect-ratio: "16-9", footer: utils.display-current-heading(level: 1), config-info(
  title: [AIに30分でiOSアプリ実装させた話],
  subtitle: [YUMEMI.grow Mobile \#24],
  author: [宇佐見公輔],
  date: datetime(year: 2025, month: 8, day: 27),
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
      - I/O 8月号にWWDC25の記事を寄稿
      - iOSDCにパンフレット記事が採択
    ],
    rect(stroke: gray, image("images/iOSDC_RealityKit.png", width: 87%)),
  ),
  rect(stroke: gray, image("images/4868m.jpg")),
)

= 今回の話に至った経緯

== 今回の話

今回の話は「AIに30分でiOSアプリ実装させた話」。

まずは、なぜそれを行ったかという経緯から。

== 経緯

=== ゆめみ社内のAIイベント「瞬作」大会
- その場でアプリのお題が与えられる
- 30分で成果物を見せる
- 成果物はなんでもよい
- AIを活用する

== 実際に行ったこと

この大会にエントリーして、次を行った。

- AIにiOSアプリを実装させた
- そのアプリが動いているデモ動画を見せた
  - リモート参加だったので動画を提出

=== AIの利用方法
- アプリ仕様はAIチャットで対話的に決めた
- アプリ実装はAIエージェントにすべてまかせた

= 基本戦略

== 大会ルールに対する検討

事前にお題がわからない。

- あくまでお題であって詳細な仕様は与えられない
- 何を作るか自体をその場で考える必要がある

AIが30分でどこまで作業できるか。

- Webフロントエンドなら実装までいけそう
- ネイティブアプリの実装は大変そう
- アプリ実装以外の成果物もありうる
  - ただ、エンジニアとしてはアプリ実装を出したい

== ネイティブアプリの実装の大変さ

- 新規プロジェクト作成が手間
  - IDE頼みのため、軽量なプロジェクト作成手段がない

- コードのビルドが必要
  - ビルドが遅い傾向にある

- アプリ実行にシミュレータか実機が必要
  - ブラウザでの実行に比べて不便

- AIの知識不足
  - AI生成のコードに不備が多い

== ネイティブアプリの実装をやりたい理由

大変さはあるものの、AIでのネイティブアプリ実装はやりたい。

- プロトタイピングだと考えた場合
  - プロトタイプなら、さほどこだわらなくてもいい
  - ただ、やはりネイティブUIらしさがあるとより良い

- プロトタイピングより先まで考えた場合
  - 良いものができたら、そのままプロダクト開発につなげたい

== ネイティブアプリの実装のための戦略

今回はiOSネイティブアプリの実装に挑戦した。

- お題から仕様書の生成はAIチャットで対話的に
  - 仕様決めがうまくないと失敗する
  - そのため、AIのレスポンスを見て細かい指示出しをする

- 新規プロジェクト作成は人間の手で先にやっておく
  - AIにプロジェクト作成をやらせると失敗する
  - 事前にできる設定はやっておく

= AIのための準備

== AIの選択肢

=== CLI型
- Claude Code
- Gemini CLI
- その他いろいろ

=== IDE連動型
- Cursor
- Visual Studio Code + GitHub Copilot
- Xcode 26
- その他いろいろ

== 実際の選択

Claude Codeを採用。

- 今回は自律的に動いて最後までやってほしい
  - 与えられた仕様書から、動くアプリを実装するところまで
  - できるだけ確認を求めてこないように

- IDEは不要
  - 人間が編集作業をしないのでIDEは不要
  - 最終的にXcodeでビルドしてシミュレータで実行できればいい

== AIの比較

- iOSアプリ開発ではAnthropicのAIが強い印象

- Claude Code
  - 自律的に動く能力が高い
    - プロンプトで細かく指示しなくてもなんとかなる

- Cursor
  - IDEがあるのは強み
    - ただ、用途によっては不要

== AIのためのルール整備

- あらかじめ、ルールを記述したファイルを用意しておく。
- SwiftLintなどをAIに使わせる。

現在、ゆめみ社内でテンプレートリポジトリの整備中。
- 興味ある人は、来月のiOSDCでゆめみブースへ

今回は僕もそのテンプレートリポジトリを利用させてもらった。

= 実装させてみて

== 実際の大会での成果

- 無事にClaude CodeにiOSアプリ実装させられた
  - Xcodeでのビルド、実行、動画キャプチャは手動で実施

- ひとまずやりたかったことはできた
  - 審査結果はまだ出てない

== 30分で実装できた

- iOSアプリ実装はやはり時間がかかる
  - ビルドが通るコードを書くだけで大変
  - ビルドエラー、修正、再ビルド、を繰り返した

- ただ、30分あればなんとかなる
  - 人間は手を出さず、Claude Codeに任せる

- 30分で終わる内容であることも大事
  - 仕様書作成時に作業時間を見積もらせておく

== 不備は多い

- アプリの動作を見ると不備は多い
  - ナビゲーションやスクロール関連の不備

- コードもあやしい部分が多い
  - 設計の文書を見てくれてはいる
  - なんとなくの体裁は整っている
  - iOSアプリ実装の知識不足か

= まとめ

== AIに30分でiOSアプリ実装させた話

- 難しいという印象があったが、工夫次第で意外とできた

- 不備はまだ多いが、いずれはもっと任せられるかも
