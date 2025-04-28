#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: utils.display-current-heading(level: 1),
  config-info(
    title: [テーブルのセルの VoiceOver 対応],
    author: [宇佐見公輔],
    date: [2025-04-23 / YUMEMI.grow Mobile \#21],
    institution: [株式会社ゆめみ],
    logo: [#image("images/Profile_NFT.jpeg", height: 35%)],
  ),
)
#set text(font: ("0xProto", "IBM Plex Sans JP"), size: 24pt)
#show math.equation: set text(font: "STIX Two Math", size: 24pt)
#show raw: set text(font: "0xProto", size: 24pt)
#show raw.where(block: true): set block(fill: rgb("#f3ede6"), inset: 1em)
#show link: it => underline(text(blue, it))
#title-slide()

== 自己紹介

#grid(
  columns: 2,
  gutter: 1em,
  [
    === 宇佐見公輔（うさみこうすけ）
    - 株式会社ゆめみ iOSテックリード

    === 近況
    - 『モバイルアプリアクセシビリティ入門』読書会に継続参加中
    - Nagoya.swift \#1 参加予定
  ],
  [
    #rect(image("images/978-4-297-14603-0.jpg"))
  ],
)

== 今日の話

- 先月は、「VoiceOver APIの基本」という話をしました
- 今日は、CollectionViewやTableViewのCellのVoiceOver対応について話します

= セルのVoiceOver対応

== 基本的なVoiceOver対応

- 標準コンポーネントはデフォルトで対応している
- 必要に応じてカスタマイズできる

=== カスタマイズ
- `accessibilityLabel`
  - 読み上げる内容をカスタム指定する
- `accessibilityTraits`
  - UI要素の種類や性質を指定する

== セルはちょっと注意が必要

CollectionViewやTableViewのCellは、普通のUI要素とは扱いが少し異なる。

- Cell自身はVoiceOver対応ではない
- VoiceOverでは、Cellの中のUI要素が読み上げられる
- これにより、デフォルトでも読み上げはされる

== デフォルトの状態で発生する問題

Cellはデフォルトでも読み上げはされるが、問題もある。

#grid(
  columns: (2fr, 1fr),
  gutter: 1em,
  [
    - Cellの中のUI要素がそれぞれ読み上げられると、次のCellに移動しづらい
      - スワイプでUI要素をひとつずつ移動してしまう
    - 理想は、Cell全体を1つのUI要素として読み上げてほしい
  ],
  [
    #image("images/cell.png", width: 100%)
  ],
)

== セルをひとつの要素とするための対応

Cellの `isAccessibilityElement` を `true` にすればよい。

```swift
cell.isAccessibilityElement = true
cell.accessibilityLabel = "読み上げ内容"
```

- Cell自身の情報を読み上げるようになる
  - Cellの中のUI要素は読み上げられなくなる
- 読み上げ内容は自前で指定する必要がある
  - `accessibilityLabel` を使う

== トレイトも指定する

`accessibilityTraits` を指定すると、より良くなる。

```swift
cell.isAccessibilityElement = true
cell.accessibilityLabel = "読み上げ内容"
cell.accessibilityTraits = .button
```

- Cellがタップできる場合には `.button` を指定しておくと良い
  - 「ボタン」と読み上げられる
  - VoiceOver利用者に、タップできることを伝える

== セルの選択状態

Cellの選択状態も伝えたい。実は何もしなくても対応される。

- CollectionViewやTableViewは選択状態を管理している
  - Cellの `isSelected` が自動制御される
  - そのため、何もしなくても選択状態を読み上げてくれる

もし選択状態の管理が標準の方法でないなら、自前で指定する。

```swift
cell.accessibilityTraits.insert(.selected)
cell.accessibilityTraits.remove(.selected)
```

= Custom Content API

== セルの内容をどこまで読み上げるか

Cellの読み上げ内容は `accessibilityLabel` で指定するが、情報量が多い場合にどうするか。

ひとつのCellの読み上げが終わるまでに時間がかかってしまう。

ただ、それも悪いわけではない。
- Cell単位でスワイプ移動できるようになっていれば、途中で中断して次のCellに移動できる

むしろ、読み上げの情報量を変に減らすのも良くない。
- VoiceOver利用者が受け取れる情報量が減ってしまう

== Custom Content APIを使う

すべてを `accessibilityLabel` に指定するかわりに、Accessibility Custom Content API（`AXCustomContent`）を使うという方法がある。

- `AXCustomContentProvider` プロトコル
  - `accessibilityCustomContent` プロパティを実装する
    - `[AXCustomContent]` を返す

`accessibilityCustomContent` の内容は、「その他のコンテンツ」として読み上げられる。

== VoiceOverローター

「その他のコンテンツ」はVoiceOverローターで選択できる。

#image("images/voiceover-more-contents.png", height: 70%)

#text(
  size: 20pt,
  [
    （WWDC21「データリッチなAppにおけるVoiceOver体験の最適化」より）
  ],
)

== Custom Contentの指定でどうなるか

- Cellの読み上げ
  - `accessibilityLabel` の内容が読み上げられる
- VoiceOverローターで「その他のコンテンツ」を選択
  - `accessibilityCustomContent` の内容が読み上げられる
  - 複数ある場合は、スワイプで読み上げる内容を切り替えられる

== Custom Contentの重要度の指定

また、`AXCustomContent` で `importance` を指定できる。
`importance = .high` にすると挙動が変わる。

- Cellの読み上げ
  - `accessibilityLabel` の内容が読み上げられる
  - 続けて `accessibilityCustomContent` で `.high` の内容も読み上げられる

== セルの読み上げの改善

`accessibilityLabel` と `accessibilityCustomContent` を組み合わせることで、読み上げの内容を調整できる。

情報量が多いCellについて、

- Cellの読み上げでは重要な情報を提供する
- VoiceOverローターで「その他のコンテンツ」を選択すると詳細な情報を提供する

これによって、Cellの読み上げの量を調整しつつ、利用者が受け取れる情報量も減らさないようにできる。

= 見出しの活用

== 複数のセクションがある場合

CollectionViewやTableViewは、複数のセクションに分かれていることがある。

その場合、セクションヘッダーのVoiceOver対応をしておくと良い。

== セクションヘッダーのVoiceOver対応

Cellと同様の対応をする。

```swift
header.isAccessibilityElement = true
header.accessibilityLabel = "読み上げ内容"
header.accessibilityTraits = .header
```

- `accessibilityTraits` は `.header` を指定する
  - 「見出し」と読み上げられる
  - VoiceOverローターで「見出し」を選択すると、header要素だけを読み上げ・移動できる

= まとめ

== テーブルのセルのVoiceOver対応

- Cellの `isAccessibilityElement` を `true` にして、`accessibilityLabel` を指定する
- `AXCustomContent` を使うと、Cellの読み上げを調整できる
- セクションヘッダーもVoiceOver対応をする
