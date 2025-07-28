#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#show: metropolis-theme.with(aspect-ratio: "16-9", footer: utils.display-current-heading(level: 1), config-info(
  title: [Apple Style Guideを読む],
  author: [宇佐見公輔],
  date: [2025-07-28 / YUMEMI.grow Mobile \#23],
  logo: image("images/Profile_NFT.jpeg", height: 35%),
))
#set text(font: ("0xProto", "IBM Plex Sans JP"), size: 24pt)
#show raw: set text(font: ("0xProto", "IBM Plex Sans JP"), size: 24pt)
#show raw.where(block: true): set text(font: ("0xProto", "IBM Plex Sans JP"), size: 20pt)
#show raw.where(block: true): set block(fill: rgb("#f3ede6"), inset: 1em)
#show link: it => underline(text(blue, it))
#show math.equation: set text(font: "STIX Two Math", size: 24pt)
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
        - 原稿提出済み
    ],
    rect(stroke: gray, image("images/iOSDC_RealityKit.png", width: 87%)),
  ),
  rect(stroke: gray, image("images/4868m.jpg")),
)

== 今日の話

#grid(
  columns: 2,
  gutter: 1em,
  [
    === iOSDCに応募したトーク記事
    - 残念ながら不採択
    - 今日はLT版に編集して話す
  ],
  rect(stroke: gray, image("images/iOSDC_AppleStyleGuide.png")),
)

= 『Apple Style Guide』とは

== Apple Style Guide

#rect(stroke: gray, image("images/AppleStyleGuide.png", width: 87%))

https://support.apple.com/guide/applestyleguide

== Appleのガイドライン

=== Human Interface Guidelines
- Apple製品向けアプリのデザインのガイドライン
- iOSアプリ開発者にとって必読
=== Apple Style Guide
- Apple製品に関する用語や表現のガイドライン
- UIやドキュメントの正しい表記や表現を知る
- これも開発者は知っておきたい

== 配布形態

=== Web版
- Appleのサイトにある
- ただ、トップからたどり着くのが難しい（検索したほうが早い）
=== PDF版
- Web版のトップにPDF版も置いてある
- 最新版（June 2025）は243ページ

= Apple Style Guideの内容

== 目次

- Style and usage（用語集、212ページ）
- Writing inclusively（インクルーシブな記述、7ページ）
- Units of measure（数量や単位の表記、7ページ）
- Technical notation（コードなどの技術的な表現、2ページ）
- International style（国際的スタイルでの表記、5ページ）

（目次から抜粋。ページ数はPDF版より）

== 読み方

用語集は、数字、A、B、C、…と並んでいて、辞書的に使う構成になっている。

用語集が内容の大部分を占める、国語辞書＋付録のようなイメージ。
一般的なガイドラインのように、各セクションを順に読むという形式ではない。

辞書を「読む」＝気になる用語を開いて、その派生語を見たり前後を見たりする読み方になる。

= 用語紹介

== ピックアップ基準

ここから、いくつか用語をピックアップして紹介していく。

次のような例をピックアップした。

- アプリ開発で参考になる
- Appleの考えかたに触れられる

= Apple Account

== 「Apple ID」ではない

- [適切] Apple Account
- [不適] Apple ID

=== 補足
- 昨年、「Apple ID」から「Apple Account」に名称変更された

== サインインの表現

- [適切] Sign in to your Apple Account
- [不適] Sign in with your Apple Account

=== 補足
- Apple Account「に」サインインする
- Apple Account「で」（デバイスやサービスに）サインインするのではない
- アカウントという概念をどう捉えるかの参考になる

== 関連：Sign in with Apple

- [適切] Sign in with Apple
- 大文字小文字に注意

ユーザーがAppやWebサイトに、Apple Accountを使って安全にサインインする機能。

=== 補足
- 「Sign in with Apple」は機能の名称なので正確に

== サインイン時の入力

- [適切] メールアドレスを入力し、パスワードを入力する
- [不適] Apple Accountを入力し、パスワードを入力する

=== 補足
- 「Apple Account」という語でメールアドレスを意味することにはならない

= crash

== 「クラッシュ」とは言わない

- [適切] 予期せず終了する
- [適切] 応答しない
- [適切] 応答を停止する
- [不適] クラッシュする

=== 補足
- 「クラッシュ」という語は、ハードウェアやソフトウェアの損傷を連想させ、ユーザーに誤解を招く

== 関連：Crash Detection

- [適切] Crash Detection
- 大文字小文字に注意

#link(
  "https://support.apple.com/ja-jp/104959",
)[事故に遭ったときにiPhoneやApple Watchの衝突事故検出で助けを呼ぶ - Apple サポート (日本)]

=== 補足
- 「クラッシュ」という語が、実際に衝突事故の意味で使われている

= error message

== ユーザー向けには「エラー」とは言わない

- [適切] メッセージ
- [適切] アラートメッセージ、警告メッセージ
- [不適] エラーメッセージ

=== 補足
- 「エラー」という語は開発者向け
- 開発者向け資料で「エラーメッセージ」という語を使うのは適切

== 言い回しに注意を払う

「エラー」という語を避ける理由は明確な言及がないが、次のような理由と推測される。

- 何かを間違えたかとユーザーを不安にさせる
- システム側に深刻な問題が起こったと誤解させる

もし「システムエラー」「タイムアウトエラー」などの語をアラートに表示している場合、言い換えを検討するとよい。

= push notification

== ユーザー向けには使わない

- [不適] プッシュ通知
- [適切] 通知

=== 補足
- プッシュ通知という語は開発者向け
- 開発者向け資料で「プッシュ通知」という語を使うのは適切

== 専門用語を避ける

「プッシュ通知」という語を避ける理由は明確な言及がないが、次のような理由と推測される。

- 専門用語はユーザーが理解しづらい
- より簡明な語がある

通知がプッシュ型であるかどうかの区別は、ユーザーにとってさほど重要ではない。

= まとめ

== Apple Style Guideを読もう

- Apple Style Guideも開発者は知っておきたい
- 辞書のような存在
- 「読む」＝気になる用語を開いて、そこから前後を見る
- 最初のとっかかりとして、今回紹介したものを見ると良いかも
