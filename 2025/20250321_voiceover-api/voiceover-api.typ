#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: utils.display-current-heading(level: 1),
  config-info(
    title: [VoiceOver API の基本],
    author: [宇佐見公輔],
    date: [2025-03-21 / YUMEMI.grow Mobile \#20],
    institution: [株式会社ゆめみ],
    logo: [#image("images/Profile_NFT.jpeg", height: 35%)],
  ),
)
#set text(font: ("0xProto", "IBM Plex Sans JP"), size: 24pt)
#show math.equation: set text(font: "STIX Two Math", size: 24pt)
#show raw: set text(font: "0xProto", size: 24pt)
#show link: it => underline(text(blue, it))
#title-slide()

== 自己紹介

- 宇佐見公輔（うさみこうすけ）
  - 株式会社ゆめみ iOSテックリード

#grid(
  columns: 2,
  gutter: 1em,
  [
    === 近況
    - 引き続き「モバイルアプリアクセシビリティ入門」読書会に参加中

    https://gihyo.jp/book/2024/978-4-297-14602-3
  ],
  [
    #rect(image("images/978-4-297-14603-0.jpg", height: 55%))
  ],
)

== 月刊I/Oに記事が掲載されました

#grid(
  columns: 2,
  gutter: 1em,
  [
    - 月刊I/O 2025年4月号
    - 「iOS 18の視線トラッキング」を書きました

    https://www.kohgakusha.co.jp/books/detail/4852
  ],
  [
    #rect(image("images/4852m.jpg", height: 75%))
  ],
)



= アクセシビリティとVoiceOver

== iOSのアクセシビリティ

#grid(
  columns: 2,
  gutter: 1em,
  [
    === 視覚サポート
    - 読み上げ（VoiceOver）
    - 文字サイズ変更
    - ダークモード など

    === 音声サポート
    - 音声合成 など
  ],
  [
    === 身体サポート
    - 視線トラッキング
    - 音声コントロール
    - スイッチコントロール など

    === 認知サポート
    - アシスティブアクセス など

    === 聴覚サポート
    - 字幕 など
  ],
)

== VoiceOver

- iOSでUIの要素を読み上げる機能
  - AndroidのTalkBackに相当

- 全盲など視覚障害があってもアプリを利用できる
  - なお、弱視などある程度見える人も利用している

- アプリ開発時のアクセシビリティ対応で行う機能の代表格
  - 多くの人はこのUI読み上げ機能を思い浮かべる
  - 本当はアクセシビリティ対応っていろいろあるけど

= VoiceOver対応の基本

== デフォルト動作

- デフォルトで、ある程度適切に読み上げられる
  - 標準コンポーネントの強み
  - この点は、Webとモバイルアプリの違いのひとつ

- ただし、いくつかの場合に実装が必要
  - 画像のみのコンポーネント
  - カスタムコンポーネント など

== `accessibilityLabel`

デフォルトの読み上げでうまくいかない場合に利用する。

```swift
var body: some View {
    Button(...) {
        // 画像のみ（テキストがない）
        Image(systemName: "heart")
    }
    // 指定しないと画像リソース名が読み上げられてしまう
    .accessibilityLabel("いいね")
}
```

== `accessibilityTraits`

UI要素の種類や性質を指定する（カスタムコンポーネント向け）。

- 種類
  - `button`（「ボタン」と読み上げてくれる）など

- 状態
  - `selected`（「選択中」と読み上げてくれる）など

- 性質
  - `header`（「見出し」とみなす）など

== SwiftUIとUIKit

基本的に、SwiftUIとUIKitのどちらでも同様のことができるが、APIは異なる（主に、モディファイアとプロパティの違い）。

```swift
// SwiftUI
CustomButton(...)
.accessibilityAddTraits(.isButton)

// UIKit
customButton.accessibilityTraits = [.button]
```

= 他のVoiceOver API

== 基本API

前述の2つでほとんどの場合は問題ない。

- `accessibilityLabel`
- `accessibilityTraits`

一方で、VoiceOver関連はAPIがたくさんある。

知っておくと有益な場合もあるかも。

== ヒント情報を追加する

読み上げ内容は基本的に `accessibilityLabel` で与えるが、追加の情報を `accessibilityHint` で与えることができる。

```swift
Button(...)
.accessibilityLabel("削除")
.accessibilityHint("このアイテムを削除します")
```

- 基本的に、ラベルだけで分かるようにする
- より詳しい説明をヒントで与える
  - ヒントは読み上げられない場合もある

== 読み上げ順序を制御する（SwiftUI）

読み上げ順序を指定するには、SwiftUIでは、`accessibilitySortPriority` を使う。

```swift
// SwiftUI
Text("後に読み上げ（優先度が低い）")
.accessibilitySortPriority(10)

Text("先に読み上げ（優先度が高い）")
.accessibilitySortPriority(20)
```

== 読み上げ順序を制御する（UIKit）

UIKitでは、`accessibilityElements` を使う。

```swift
// UIKit
override var accessibilityElements: [Any]? {
    get {
        [firstElement, secondElement]
    }
}
```

== 能動的に通知する

重要な通知、モーダル表示やレイアウト変更を伝えたい、など。

```swift
// SwiftUI
AccessibilityNotification
    .Announcement("メッセージ").post()

// UIKit
UIAccessibility.post(
    notification: .announcement,
    argument: "メッセージ")
```

== 読み上げ音声の調整

読み上げ音声のピッチや言語を調整できる。

- UIKit : `accessibilityAttributedLabel`
- SwiftUI : `accessibilityLabel(Text())`

`AttributedString` にはアクセシビリティ関連の要素がある。

- `accessibilitySpeechPitch`
- `accessibilitySpeechLanguage`
- `accessibilitySpeechSpellOut`

== リファレンス

Apple Developer Documentation の次の場所にある。

=== フレームワーク
- #link("https://developer.apple.com/documentation/accessibility")[Accessibility]

=== SwiftUI
- #link("https://developer.apple.com/documentation/swiftui/view-accessibility")[Accessibility modifiers]

=== UIKit
- #link("https://developer.apple.com/documentation/uikit/accessibility-for-uikit")[Accessibility for UIKit]
- #link("https://developer.apple.com/documentation/uikit/uiaccessibility-protocol")[UIAccessibility]

== リファレンスの特徴

ドキュメントとして充実している。

- 全体的な説明文がわりとちゃんと書かれている
- アクセシビリティ関連でまとめられているので、VoiceOver以外も含めてたくさんある

ただ、多いので読むのが大変。リファレンスの細かい項目は説明が少ないものもある。

- 関連するデータ構造などが多い
- APIの細かい要素になってくると記述がなくなる傾向はある

= VoiceOver対応の整理

== VoiceOver対応の整理

実のところ、一番大変なのはAPIの問題ではなくて、実際に読み上げてみて、どう読まれるかを確認すること。そこは頑張るしかない。

一方、APIはたくさんあるものの、基本APIはふたつ。それ以外を必要に応じて少しずつ追加対応していくとやりやすい。

- `accessibilityLabel`
- `accessibilityTraits`
