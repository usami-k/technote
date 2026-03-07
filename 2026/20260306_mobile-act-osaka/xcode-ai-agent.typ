#import "@preview/touying:0.6.1": *
#import themes.stargazer: *
#show: stargazer-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: "Xcode 26.3のAIエージェント機能を活用する",
    author: "宇佐見公輔",
    date: datetime(year: 2026, month: 3, day: 6),
    logo: image("images/Profile_NFT.jpeg"),
  ),
)
#set text(font: ("0xProto", "BIZ UDGothic"))
#show raw.where(block: false): set text(fill: rgb("#005bac").darken(60%))
#show raw.where(block: true): set block(fill: rgb("#005bac").lighten(90%), inset: 1em)
#show link: it => if type(it.dest) == str { underline(it) } else { it }

#title-slide()

== 自己紹介

#grid(
  columns: 2,
  gutter: 2em,
  [
    === 宇佐見公輔（うさみこうすけ）
    - iOSアプリエンジニア
    - アクセンチュア株式会社／ゆめみ

    === 近況
    - 40%キーボードに手を出した
    - ディスプレイ購入検討中
  ],
  [
    === 昨年の技術同人誌
    #grid(
      columns: 2,
      gutter: 1em,
      rect(stroke: gray, image("images/BookTesting.png")), rect(stroke: gray, image("images/BookTypst.png")),
    )
  ],
)

#outline-slide()

= Xcode 26.3の登場

== Xcode 26.2までのAI機能

- Xcode 26でCoding Intelligence機能が導入された

- しかし、機能は限定的だった
  - ChatGPTやClaudeのチャット機能が基本
  - ビルドエラーをAIに修正させる→あまりうまくいかない
  - プロジェクト全体をうまく把握できない

- 結局、CLIやVS CodeでAIを動かしたほうがうまくいく

== Xcode 26.3のAI機能強化

- Xcode 26.3でCoding Intelligence機能が強化された

- エージェント機能追加
  - Claude Code
  - Codex

- MCP対応
  - 外部AIエージェントがXcodeにアクセス可能に

= XcodeのAIエージェント機能

== ドキュメント

- Setting up coding intelligence

https://developer.apple.com/documentation/Xcode/setting-up-coding-intelligence

- Writing code with intelligence in Xcode

https://developer.apple.com/documentation/Xcode/writing-code-with-intelligence-in-xcode

== Xcodeのコンポーネント設定

シミュレータなどのコンポーネント一覧にAIエージェントが追加されている。

#rect(stroke: gray, image("images/Agents.png"))

== Xcodeのアカウント設定

OpenAIとAnthropicに接続できる（有償ライセンスが必要）。

#rect(stroke: gray, image("images/Accounts.png", height: 70%))

== XcodeのUI

#grid(
  columns: (2fr, 3fr),
  gutter: 1em,
  [
    - Xcodeのナビゲータ領域にコーディングアシスタント
  ],
  rect(stroke: gray, image("images/coding-assistant-write-code~dark@2x.jpg")),
)

== 主な機能

- プロジェクト全体のファイルの読み書き
- 外部ツールの利用（Xcodeの設定で許可が必要）
- ビルド実行、テスト実行
- プレイグラウンドの生成
- プレビューの生成

CLIやVS CodeでのAIエージェント使用時と同等のことがXcodeで可能に。

== 外部ツールの利用

- CLIの各種コマンドやWebFetchなどを利用できる
- 個別に許可が必要
- 許可したツールはXcodeの設定で確認できる

#rect(stroke: gray, image("images/Permissions.png"))

= XcodeのMCP対応

== ドキュメント

- Giving external agentic coding tools access to Xcode

https://developer.apple.com/documentation/Xcode/giving-agentic-coding-tools-access-to-xcode

== Xcodeの設定

- 外部AIエージェントを許可する

#rect(stroke: gray, image("images/MCP.png"))

== AIエージェントの設定

AIエージェントから `xcrun mcpbridge` コマンドを利用する。

- Claude Code

```shell
claude mcp add --transport stdio xcode -- xcrun mcpbridge
```

- Codex

```shell
codex mcp add xcode -- xcrun mcpbridge
```

== MCPの利用方法

- Xcodeを起動しておく

- AIエージェント（Claude Code、Codex）を起動する
  - Xcode側で接続確認のダイアログが出るので、許可する

- AIエージェントが自分で判断してXcode MCPを利用する

== MCPで可能な操作

- プロジェクト内のファイルの読み書き
- Xcodeのウィンドウやナビゲータの情報取得
- ビルド実行、テスト実行
- コードスニペット実行
- プレビューのレンダリング

AIエージェントからXcodeの機能が使いやすくなった。

= 実際に使ってみる

== Xcode vs 外部AIエージェント

- 機能的は差はあまりない
  - Xcodeがようやく追いついてきた

- Xcode上で完結させたい vs 外部AIエージェントで柔軟に使いたい
  - 何がしたいかによる
  - あるいは好みの問題

== 個人的な利用シーン

- 個人的にはXcodeのAIエージェントを使ってみていた
  - AIエージェントを継続的に稼働というより、タスクごとに稼働

- ただ、並行して別のAIエージェントを動かしたいときもある
  - そのときは別途CLIやVS Codeを活用

- 利用シーンを振り返ると、Xcode固有というより、AIエージェント全般の話になってくる
  - それだけXcodeがAIエージェントの機能をサポートするようになった

== SwiftやiOSの知識向上

- Swift
  - ConcurrencyやSwiftUIをうまく扱える
  - Testingも扱えるようになってきた（たまにXCTestとの混乱が見られる）

- iOS
  - プラットフォームやフレームワークの知識が向上している
  - たまに、Webなどの古い情報に釣られることはある

- 「iOSアプリ開発ではAI活用はまだまだ」という状況はもう過去の話

== GitHub Issueをもとに作業

- Issueの調査依頼、Pull Requestのレビュー依頼、など
  - `gh` コマンドを許可すれば、詳細な情報を取得してくれる

- `gh` コマンドをXcodeのAIエージェントに使わせる
  - miseなら `mise x -- gh` と使ってくれる
  - Homebrewなら `/opt/homebrew/bin` などパスを教えれば使ってくれる

- WebFetchもできる、ただプライベートリポジトリは読めない

== Planモードと編集モード

- Xcode上では、明示的にPlanモードの指定はできない

- ただ、調査を依頼したりプランを立てる依頼をしたりすれば、内部的にPlanモードで動いてくれるようだ
  - EnterPlanModeを実行している様子が見える場合がある

- AIエージェントが編集した内容はXcode上で記録されていて確認できる
  - 内容を戻す操作も可能

== 広い範囲を調査

- 広い範囲を見てくれるようになった
  - プロジェクト全体を見てくれる
  - Gitの履歴も見てくれる
  - 必要なら他のリポジトリも見てくれる

- ユーザー設定も見てくれる
  - Xcodeの設定、Gitの設定、SSHの設定、など
  - ビルドキャッシュを削除するなどもできる

== ビルド

- 必要に応じてビルドしてくれる
  - `AGENTS.md` などにビルド手順を明示的に書くとベター

- ただ、ビルド時間が長いと完了を待たないことがある
  - ビルド完了を待つように指示することはできる
  - 初回ビルドなどは先に手動でやっておくほうが良い

- ビルドエラーの修正
  - うまく修正できずに混乱することもあるので様子を確認する

== テスト、プレビュー

- テストコードが書ける
  - テストが必要な箇所を見つけられる
  - ただ、意味がないテストを書く場合もあるので注意
    - テストデータを本番コードで生成してしまうなど

- プレビューコードが書ける
  - プレビューのパターンを洗い出せる
  - プレビューを実行してくれる
  - プレビュー結果を見てコードを修正

= まとめ

== まとめ

- Xcode 26.3でAIエージェント機能が大幅に強化された
  - Claude Code
  - Codex

- iOSアプリ開発においてAIエージェントを積極的に活用できる状況に
