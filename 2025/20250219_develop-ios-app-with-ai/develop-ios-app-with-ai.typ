#import "@preview/touying:0.5.5": *
#import themes.metropolis: *
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: utils.display-current-heading(level: 1),
  config-info(
    title: [iOSアプリ開発でも\ AIの助けを借りたい],
    author: [宇佐見公輔],
    date: [2025-02-19 / YUMEMI.grow Mobile \#19],
    institution: [株式会社ゆめみ],
    logo: [#image("images/Profile_NFT.jpeg", height: 35%)],
  ),
)
#set text(font: ("0xProto", "IBM Plex Sans JP"), size: 24pt)
#show math.equation: set text(font: "STIX Two Math")
#show raw: set text(font: "0xProto")
#show link: it => underline(text(blue, it))
#title-slide()

== 自己紹介

- 宇佐見公輔（うさみこうすけ）
  - 株式会社ゆめみ iOSテックリード

=== 近況

- 「#link("https://yumemi.notion.site/beba018e485946f696ac72613e1a9a30")[ゆめみ大技林]」
  - 社外の方で執筆に参加してくださる方を募集中
  - 一緒に本を作りませんか？
- ゆめみの「#link("https://yumemi.notion.site/office")[出社原則]」
  - 注意 : 「原則」という語はテクニカルタームで定義がある
  - 僕自身は、堺から京都オフィスまで片道2時間で例外に該当

= iOSアプリ開発環境

== iOSアプリ開発環境は何があるか

iOSアプリ開発ができる環境は限られています。\ 前提条件として、Macが必要です。

- Xcode
- Xcode以外のIDE（内部的にXcodeの機能を呼び出す）
  - Visual Studio Code
  - Cursor
  - JetBrains Fleet

== iOSアプリ開発でAIアシストを得るには

iOSアプリ開発でAIの助けを借りるには、それらの開発環境に対応したAIツールが必要です。

- Xcode
  - Xcode自身の機能
  - サードパーティー製のXcode拡張
- Xcode以外のIDE
  - それぞれのIDEに対応したAIツール

== 補足 : Swift Build

XcodeのビルドシステムであるSwift Buildがオープンソース化されました。

将来は、iOSアプリ開発ができる環境が増えるかもしれません。

#text(
  size: 16pt,
  [
    === 参考
    #link("https://www.swift.org/blog/the-next-chapter-in-swift-build-technologies/")[Swift.org - The Next Chapter in Swift Build Technologies]
  ],
)

= Xcode + AIアシスト

== Predictive Code Completion

#grid(
  columns: (1fr, 2fr),
  gutter: 1em,
  [
    - コード補完機能
    - Xcode 16の機能
    - macOS 15が必要
  ],
  [
    #image("images/PredictiveCodeCompletion.jpeg")
  ],
)

== Swift Assist

#grid(
  columns: (1fr, 2fr),
  gutter: 1em,
  [
    - 編集アシスト機能
    - WWDC 2024で発表
    - 未リリース
  ],
  [
    #image("images/SwiftAssist.jpeg")
  ],
)

== GitHub Copilot for Xcode

- GitHub Copilot公式のXcodeサポート

#align(
  center,
  [
    #image("images/GitHubCopilot.jpg", height: 80%)
  ],
)

== ChatGPT : Work with Apps on macOS

- ChatGPT公式のアプリ連携機能がXcodeをサポート

#align(
  center,
  [
    #image("images/ChatGPT.png", height: 80%)
  ],
)

= Xcode以外のIDE

== Visual Studio Code

- 拡張機能が豊富
  - SweetPad拡張機能でiOSアプリ開発が可能
- 拡張で各種のAI機能が使える
  - GitHub Copilot
  - GitHub Copilot Chat
  - Cline

#text(
  size: 16pt,
  [
    === 参考
    #link("https://qiita.com/usamik26/items/50f22983fcac0bbd6e74")[SweetPadを使ってVisual Studio CodeやCursorでiOSアプリ開発を行う - Qiita]
  ],
)

== Cursor

- CursorはVSCodeベース
  - 前述のSweetPad拡張機能でiOSアプリ開発が可能
- CursorのAI機能が使える
  - Composer
  - Agent

== JetBrains Fleet

- FleetはiOSアプリ開発もサポートしている
  - JetBrainsは以前はAppCodeがあったがサポート終了
- JetBrains AIが使える
  - チャット
  - 編集アシスト

= 個人的な所感など

== AIはSwiftの新しい機能に詳しくない

Swiftの新しめの機能では、あまり良い応答が得られない。

- Swift Concurrency
- Swift Testing

AIにドキュメントを参照させてうまくいかないか、と思っているが、現状あまりうまくいっていない。

== AIはiOSアプリ開発に詳しくない

iOSアプリ開発の一般的な話では、それなりに応答が得られる。

具体的なフレームワークなど細かい話になってくると、あまり良い応答が得られない。

フレームワークについては、AIにドキュメントを参照させると、ある程度うまくいく。

== コード補完

コード補完では、期待通りの補完をしてくれることもそれなりにあるが、外れることも多い。

Xcodeの（AIを使わない）コード補完がわりと優秀なので、むしろ補完の邪魔になってしまうことも。

=== そもそもの話
プログラマーとしては、コードを書くのは一番楽しい部分なわけで、AIにコード生成されても嬉しくない。

ただ、生成されたコードを参考にすることはある。

== チャット機能

わからないことを聞くのにある程度は使える。ただ、前述のようにAIの知識不足で、あまり良い回答が得られないことも多い。

AIにコードレビューしてもらうのは、意外とありだと思っている。

レビュー内容が参考になることがそれなりにある。イマイチだった場合は、単に無視すればいいので気楽。

== 編集アシスト

期待通りの編集をしてくれることもそれなりにあるが、うまくいかないことも多い。

これは、Cursorなどでルール設定などをしっかりしてやれば、ある程度カバーできそうではある。

ここがうまくいけば、エージェント機能も有益になってくる。

また、Swift Assistがリリースされたら良くなるかもしれない（ただ、AppleがリリースするAIの精度が高いかどうかは・・・）。

= まとめ

== iOSアプリ開発でもAIの助けを借りたい

- Xcodeでは限定的ではあるが、AIアシストが使える
- Xcode以外のIDEでは、より多くのAIアシストが使える
- SwiftやiOSの知識は不足気味
- コード補完は、提案されるコードを参考にする感じで使う
- コードレビューしてもらうの良いかも
- 編集アシストやエージェントは、ルール設定でうまくいくかも
