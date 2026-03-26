#import "@preview/touying:0.6.1": *
#import themes.stargazer: *
#show: stargazer-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: "Xcode 26.3で変わるiOSアプリ開発とAIエージェント",
    author: "宇佐見公輔",
    date: datetime(year: 2026, month: 3, day: 25),
    logo: image("images/Profile_NFT.jpeg"),
  ),
)
#set text(font: ("0xProto", "BIZ UDGothic"))
#show raw.where(block: false): set text(fill: rgb("#005bac").darken(60%))
#show raw.where(block: true): set block(
  fill: rgb("#005bac").lighten(90%),
  inset: 1em,
)
#show link: it => if type(it.dest) == str { underline(it) } else { it }

#title-slide()

== 自己紹介

=== 宇佐見公輔（うさみこうすけ）
- iOSアプリエンジニア
- アクセンチュア株式会社／ゆめみ

=== 近況
- 技術書典20に向けて新刊を準備中
  - iOSアプリ開発でのAIエージェント活用についての本

#outline-slide()

= Xcode 26.3のAIエージェント機能

== Xcode 26.3でAI機能強化

- Xcode 26.2まではAIチャット機能
  - ちょっとした修正くらいしかできなかった
- Xcode 26.3でAIエージェント機能が統合された
  - プロジェクト全体を見てコーディング

== 2つの入り口

- XcodeのUI
  - Coding Assistantパネル
- XcodeのMCPサーバー
  - 外部AIエージェントからXcodeを利用する
- この2つは入り口が異なるが、同様のことができる

== XcodeのUIから使う

#grid(
  columns: (3fr, 2fr),
  gutter: 1em,
  rect(stroke: gray, image("images/coding-assistant-write-code~dark@2x.jpg")),
  [
    - 左側にCoding Assistantパネル
    - Claude CodeやCodexが使える
  ],
)

== 外部AIエージェントから使う

- Xcodeの設定画面でMCP機能を許可する

#rect(stroke: gray, image("images/MCP.png"))

- 外部のClaude CodeやCodexでMCPを設定する
  - `claude mcp add` や `codex mcp add` で追加

== できること

- プロジェクト全体を理解する
- ビルドやテストを実行する
- プレビュー表示する、結果を画像出力する
- Appleのリファレンスドキュメントを調べる
- 外部コマンドを実行する

== 注意点

- 外部コマンドの実行許可はXcodeの設定に保存される
  - プロジェクト単位の設定ではなさそう
- MCPサーバーにするにはXcodeを起動しておく必要がある
  - MCP接続時に毎回Xcode側で確認ダイアログが出る

== 参考情報

=== Tech Talk

- #link(
    "https://developer.apple.com/videos/play/tech-talks/111428/",
  )[Meet agentic coding in Xcode]

=== Documentation

- #link(
    "https://developer.apple.com/documentation/Xcode/setting-up-coding-intelligence",
  )[Setting up coding intelligence]
- #link(
    "https://developer.apple.com/documentation/Xcode/writing-code-with-intelligence-in-xcode",
  )[Writing code with intelligence in Xcode]
- #link(
    "https://developer.apple.com/documentation/Xcode/giving-agentic-coding-tools-access-to-xcode",
  )[Giving external agentic coding tools access to Xcode]

= iOSアプリ開発とAIエージェント

== これまでのAIとの相性の悪さ

- 開発環境が特殊
  - Xcodeが必要、重量級の開発環境
  - 軽量なエディタだけでは開発しづらい
- 開発言語が特殊
  - Swift言語
  - Apple Developer以外には使われない

== 状況の変化

- 開発環境の適合
  - 今回のXcodeのAIエージェント機能による恩恵
- 開発言語の適合
  - AIのSwift知識が向上してきた

== AIエージェントとの付き合いかた

- 自分の得意分野だからこそAIエージェントにやらせる
  - 苦手分野をやらせてもたいしたものはできない
  - 得意分野だから質を高められる
- 作業が速いパートナー
  - 頭に浮かんだことを素早く形にできる
  - 試行錯誤がしやすい

= 実業務での利用シーン

== Xcode上で作業する

- 慣れ親しんだXcodeが使える
- AIエージェントを利用した作業が一箇所で完結する
  - ターミナルや他のアプリと併用しなくてすむ
- Appleのリファレンスも調査してくれるのが便利
  - AIのSwiftやiOSの知識強化

== テスト・プレビュー

- テストコードを書かせる
  - XCTestでなくSwift Testingで書けるようになってきた
- プレビューを書かせる
  - 複数の表示パターンを書かせるのが便利
  - 画像ファイルへの出力もできる

== GitHubとの連携

- GitHub上のIssueを読ませてプランを組ませる
  - `gh` コマンドが使えるとスムーズ
- 調査内容によってはGitの履歴を探索してくれる
- Pull Requestのレビューもできる

== 使うときの注意点

- プランモードがない
  - プランを立てるよう指示すると、内部的にプランモードを使う
- ビルド完了を待たない
  - 完了を待つように指示すると、ある程度待てるようになる
  - 初回ビルドは先に手動ですませておくと良い

== 外部AIエージェントの活用

- CLIやアプリも活用できる
  - Xcodeだけでは最新の高度な機能は使えない場合がある
- Xcodeを起動しておく必要がある点は注意

= まとめ

== まとめ

- iOSアプリ開発でもAIエージェントを使いやすくなった
- XcodeのUIと外部AIエージェントのどちらでも活用できる
- 実業務でも既に有効活用できている
- 自分の得意分野だからこそうまく活用できる
