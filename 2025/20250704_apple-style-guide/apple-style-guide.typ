#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#show: metropolis-theme.with(aspect-ratio: "16-9", footer: utils.display-current-heading(level: 1), config-info(
  title: [Apple Style Guideを読む],
  author: [宇佐見公輔],
  date: [2025-07-04 / Mobile Act OSAKA 16],
  logo: [#image("images/Profile_NFT.jpeg", height: 35%)],
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
  [
    === 宇佐見公輔（うさみこうすけ）
    - ゆめみiOSテックリード

    === 近況
    - 7/5（土）大阪ライブ出演
    - 7/20（日）東京ライブ出演
    - ブレーミア結成40年
    - https://chor-vremya.com/
  ],
  [
    #rect(image("images/vremya2025.png"))
  ],
)

== 本の紹介

#grid(
  columns: 2,
  gutter: 1em,
  [
    === Swift Testing本
    - 技術書典18で#link("https://techbookfest.org/product/kNeYDqeMsjmejthYsZY4nR")[新刊]を出しました
    - 電子版を引き続き頒布中
  ],
  [
    #rect(image("images/BookTesting.png"))
  ],
)

== iOSDC Japan 2025

#grid(
  columns: 2,
  rows: 2,
  gutter: 1em,
  [
    今年もプロポーザル出しました。

    - パンフ記事は採択、執筆中
    - トーク（2本）は結果待ち

    スターください⭐️
  ],
  rect(stroke: red, image("images/iOSDC_RealityKit.png", width: 87%)),

  rect(stroke: gray, image("images/iOSDC_AppleStyleGuide.png", width: 87%)),
  rect(stroke: gray, image("images/iOSDC_SwiftTesting.png", width: 87%)),
)

= Apple Style Guideとは

== Apple Style Guide

#rect(image("images/AppleStyleGuide.png", width: 87%))

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

英語のみで、日本語版はない。

=== Web版
- Appleのサイトにある
- ただ、トップからたどり着くのが難しい
- Web検索したほうが早くたどり着ける
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

用語集が内容のほとんどなので、国語辞書＋付録のようなイメージ。
普通のガイドラインのように、各セクションを順に読むという形式ではない。

辞書を「読む」＝気になる用語を開いて、そこから派生語を見たり前後を見たりする。

== 用語紹介

ここから、いくつか用語をピックアップして紹介していく。

= Apple Account

== 「Apple ID」ではない

- ⭕️ Apple Account
- ❌ Apple ID

=== 補足
- 昨年、Apple IDからApple Accountに名称変更された

== サインインの表現

- ⭕️ Sign in to your Apple Account
- ❌ Sign in with your Apple Account

=== 補足
- Apple Account「に」サインインする
- Apple Account「で」（デバイスやサービスに）サインインするのではない
- アカウントという概念をどう捉えるかの参考になる

== 関連：Sign in with Apple

- ⭕️ Sign in with Apple
- 大文字小文字に注意

ユーザーがAppやWebサイトに、Apple Accountを使って安全にサインインする機能。

=== 補足
- これは機能の名称なので正確に。

== サインイン時の入力

- ⭕️ メールアドレスを入力し、パスワードを入力する
- ❌ Apple Accountを入力し、パスワードを入力する

=== 補足
- 「Apple Account」という言葉でメールアドレスを意味することにはならない

= crash

== クラッシュとは言わない

- ⭕️ 予期せず終了する
- ⭕️ 応答しない
- ⭕️ 応答を停止する
- ❌ クラッシュする

=== 補足
- クラッシュという言葉は、ハードウェアやソフトウェアの損傷を連想させ、ユーザーに誤解を招く

== 関連：Crash Detection

- ⭕️ Crash Detection
- 大文字小文字に注意

#link(
  "https://support.apple.com/ja-jp/104959",
)[事故に遭ったときにiPhoneやApple Watchの衝突事故検出で助けを呼ぶ - Apple サポート (日本)]

=== 補足
- Crashという言葉は、実際に衝突事故の意味で使われている
- 日本語では「衝突事故検出」という名称が使われている

= error message

== ユーザー向けにはエラーとは言わない

- ❌ エラーメッセージ
- ⭕️ メッセージ
- ⭕️ アラート、アラートメッセージ
- ⭕️ 開発者向け資料で「エラーメッセージ」という語を使う

=== 補足
- エラーという言葉は開発者向け

= push notification

== ユーザー向けには使わない

- ❌ プッシュ通知
- ⭕️ 通知
- ⭕️ 開発者向け資料で「プッシュ通知」という語を使う

=== 補足
- プッシュ通知という言葉は開発者向け

= abbreviations and acronyms

== 略語と頭字語

=== acronyms（アクロニム、頭字語）
- 複合語の頭文字や主要部から形成される単語
- 単語として発音される
- ROM : read-only memory

=== abbreviations（略語）
- 同様の方法で形成される単語
- 単語として発音されない
- MB/s : megabytes per second

== 略語と頭字語のガイドライン

この項目は、略語や頭字語についてのガイドラインでもある。

=== spell out（略さずに書く）
- 略語や頭字語になじみがない場合
  - internet service provider (ISP)
- 略語や頭字語になじみがある場合
  - URL (Uniform Resource Locator)
- spell out不要な単語
  - JPEG

== 略語と頭字語の発音

pronunciationという項目に記載がある。

- 発音が自明でないときは発音キーを提供する
  - WYSIWYG (pronounced “WIZ-zee-wig”)
- 発音キーはこのスタイルガイドに記載している
  - URL (pronounced “you-are-ell”)
  - JPEG (pronounced “JAY-peg”)
- 記載されていない場合には、独自の発音キーを書かない

= まとめ

== Apple Style Guideを読もう

- Apple Style Guideも開発者は知っておきたい
- 辞書のような存在
- 「読む」＝気になる用語を開いて、そこから前後を見る
- 最初のとっかかりとして、今回紹介したものを見ると良いかも
