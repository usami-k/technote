#import "@preview/touying:0.4.2": *

#let s = themes.metropolis.register(
  aspect-ratio: "16-9",
  footer: self => "『" + self.info.title + "』" + states.current-section-title,
)
#let s = (s.methods.info)(
  self: s,
  title: [Apple Vision ProのUI],
  author: [宇佐見公輔],
  date: [2024-07-31],
  institution: [株式会社ゆめみ],
)
#let (init, slides, touying-outline, alert, speaker-note) = utils.methods(s)
#show: init
#set text(font: "IBM Plex Sans JP", size: 26pt)
#show link: it => underline(text(blue, it))
#let (slide, empty-slide, title-slide, new-section-slide, focus-slide) = utils.slides(s)
#show: slides.with(outline-slide: false)

== 自己紹介

#grid(
  columns: 2,
  gutter: 1em,
  [
    - 宇佐見公輔

    - 株式会社ゆめみ
      - iOSテックリード

    - iOSDC Japan 2024
      - パンフレット記事執筆
      - ポスターセッション
  ],
  grid(
    rows: 2,
    image("images/c40d5199-526b-4bf9-91d7-2a0bc609b305.png", height: 50%),
    image("images/a28236ac-e8b0-4015-84e9-a0c9ac6670af.png", height: 50%)
  ),
)

== 今日の内容

#touying-outline()

= Apple Vision Proの操作方法

== Apple Vision Pro購入

#grid(
  columns: 2,
  gutter: 1em,
  [
    - Apple Vision Pro日本発売
      - 2024年6月28日

    - 日本での発売を待っていた
      - 発売日に購入
  ],
  image("images/vision_2024-06-29.jpeg"),
)

== 操作方法

次の方法が基本。

- 視線によるフォーカス移動
- 手のジェスチャによるタップ

それ以外に次の方法もある。

- 頭、手首、人差し指
- Magic Trackpad（visionOS 2 からマウスも使用可能）
- Macのトラックパッド（Mac仮想ディスプレイ使用時）
- ゲームコントローラ（対応アプリのみ）

== 視線と注視による操作

#link("https://support.apple.com/ja-jp/guide/apple-vision-pro/welcome/visionos")[Apple Vision Proユーザガイド]

丁寧なユーザガイドだが、視線や注視についてはあまり詳しく書かれていない。

#image("images/guide_tap.png")

== 理解はできるが実践が難しい

実際には次のようなことが起こる。

- 視線を移動しても、フォーカスがうまく移動しない
- 対象を注視していても、フォーカスが移動してしまう

このため、次のような問題が発生する。

- 選択したい項目に、フォーカスを当てられない
- 選択するときに、意図と異なる項目をタップしてしまう

= 視線の動きを調べる

== ポインタ表示

#grid(
  columns: (1fr, auto),
  gutter: 1em,
  [
    アクセシビリティ設定でポインタを表示できる。

    画像の中央あたりの緑丸がポインタ
  ],
  image("images/a11y_pointer.jpeg"),
)

== 補足：フォーカス項目を分かりやすくする

#grid(
  columns: (1fr, auto),
  gutter: 1em,
  [
    フォーカスのコントラストを上げる設定がある。
  ],
  image("images/a11y_contrast.jpeg"),
)

== 視線は動き回る

ポインタ表示すると、視線の動きがわかる。

- 何もしていないときに、視線はふらふらと動き回る
- 視線を移動させたときに、意識と視線は意外と一致しない
- 注視したときに、視線は固定せずに動いている

視線はじっとしていないで、常に動き回っているもの。

= UIのガイドライン

== 参考セッション・ガイドライン

- #link("https://developer.apple.com/jp/videos/play/wwdc2023/10073/")[空間入力のためのデザイン - WWDC23]
- #link("https://developer.apple.com/jp/videos/play/wwdc2023/10076/")[空間ユーザーインターフェイスのためのデザイン - WWDC23]
- #link("https://developer.apple.com/jp/videos/play/wwdc2024/10086/")[優れたvisionOSアプリのデザイン - WWDC24]
- #link("https://developer.apple.com/jp/design/human-interface-guidelines/eyes")[視線 - ヒューマンインターフェースガイドライン]

これ以外にも、visionOSのデザインに関するセッションやガイドラインがある。

== 項目の中央に視線を誘導する

#grid(
  columns: 2,
  gutter: 1em,
  [
    視線の移動や注視が難しいことを考慮した注意点がある。

    - 丸い形で中央に視線を誘導
    - 鋭い形は外側に注意が逃げる
    - 外側に縁取りを入れるのも同様によくない
  ],
  grid(
    rows: 2,
    image("images/wwdc_circle.jpeg", height: 50%),
    image("images/wwdc_edge.jpeg", height: 50%)
  ),
)

== ボタンの大きさ・間隔

#grid(
  columns: 2,
  gutter: 1em,
  [
    - ボタンのタップ領域は60pt
    - ボタンの表示領域は44pt
    - 表示領域の間隔は16pt

    ポインタが見た目で正確にあっていなくても、タップが可能になっている。
  ],
  image("images/wwdc_buttons.jpeg"),
)

= アラートのUI

== アラートのUIに対する不満

#grid(
  columns: (1fr, auto),
  gutter: 1em,
  [
    アラートは選択しづらいと感じる。

    意図と異なる項目をタップしてしまいがち。わりと厄介な結果をもたらす。
  ],
  image("images/photo_alert.jpeg"),
)

== アラートの標準実装

```swift
Button("アラートを表示") {
    showAlert = true
}
.alert("アラート", isPresented: $showAlert) {
    Button("キャンセル", role: .cancel) {
        message = "Cancel tapped"
    }
    Button("OK") {
        message = "OK tapped"
    }
}
```

== 標準実装の結果

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  image("images/my_alert.png"),
  [
    UIガイドラインの知見が活かされてない感じがする。
  ],
)

== 選択しやすいUIを考えてみる

```swift
VStack {
    Button("OK") {
    }
    .padding()
    Button("キャンセル", role: .cancel) {
    }
    .padding()
}
```

== VStackの場合

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  image("images/my_vstack.png"),
  [
    `padding` があると選択ミスしにくい

    ボタンの形が見えるほうが押しやすい

    上下の選択は難しい（個人の感想）
  ],
)

== HStackの場合

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  image("images/my_hstack.png"),
  [
    左右の選択は上下より楽（個人の感想）
  ],
)

== いっそのことこんな感じで

#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  image("images/my_hstack2.png"),
  [
    アラートの左右にボタンを置く

    選択を間違えることはない

    UIがダサい感じはある（ボタン増えたらどうするの）
  ],
)

= まとめ

- 視線と注視によるフォーカス操作は意外と難しい
- どんなUIが良いのかはまだ検討の余地がありそう
