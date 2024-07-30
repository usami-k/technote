#import "@preview/touying:0.4.2": *

#let s = themes.metropolis.register(
  aspect-ratio: "16-9",
  footer: self => "『" + self.info.title + "』" + states.current-section-title,
)
#let s = (s.methods.info)(
  self: s,
  title: [Apple Vision Proのフォーカス操作],
  author: [宇佐見公輔],
  date: [2024-07-17],
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

= Apple Vision Proの操作感

== Apple Vision Pro購入

#grid(
  columns: 2,
  gutter: 1em,
  [
    - Apple Vision Pro日本発売
      - 2024年6月28日

    - 発売日に購入

    - 翌日にオンラインイベントに登壇してみたりした
  ],
  image("images/vision_2024-06-29.jpeg"),
)

== 操作感に関する個人的な所感：良いところ

- 空間にウィンドウを置けるのが心地よい
  - パススルーのおかげで実際の空間に置いている感覚
  - Mac仮想ディスプレイとvisionOSアプリが共存する空間

- 手のジェスチャ操作は良い感じ
  - わりとちゃんと認識される

- 重さや熱さは気にならない
  - 細かいフィッティングによる良好な装着感
  - バッテリーは外付け

== 操作感に関する個人的な所感：気になるところ

- フォーカス操作が難しい
  - 視線によるフォーカス移動
  - 注視によるフォーカス固定

装着感は良いのだが、次の理由で長時間の使用がたいへん。

- 操作がうまくいかないストレス
- 視線を動かすことによる目の疲労

= 視線と注視による操作

== ユーザガイド

#link("https://support.apple.com/ja-jp/guide/apple-vision-pro/welcome/visionos")[Apple Vision Proユーザガイド]

#image("images/guide_tap.png")

丁寧なユーザガイドだが、視線や注視についてはあまり詳しくない。直感的に理解できるはず、という意図だろう。

== 理解はできるが実践が難しい

理解はできるが、実際には次のようなことが起こる。

- 視線を移動しても、フォーカスがうまく移動しない
- 対象を注視していても、フォーカスが移動してしまう

このため、次のような問題が発生する。

- 選択したい項目に、フォーカスを当てられない
- 選択するときに、意図と異なる項目をタップしてしまう

== 自分だけの問題ではなかった

自分の操作が下手なだけかとも思ったが、ゆめみの同僚も同じような感想を持っていた。

視線の設定（キャリブレーション）をやり直せば改善はしたが、根本的な解決には至らない。

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

== 視線は動き回る

ポインタ表示すると、視線の動きがわかる。

- 何もしていないときに、視線はふらふらと動き回る
- 視線を移動させたときに、意識と視線は意外と一致しない
- 注視したときに、視線は固定せずに動いている

視線はじっとしていないで、常に動き回っているもの。

== 補足：フォーカス項目を分かりやすくする

#grid(
  columns: (1fr, auto),
  gutter: 1em,
  [
    フォーカスのコントラストを上げる設定がある。
  ],
  image("images/a11y_contrast.jpeg"),
)

= 操作しやすいUIは？

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

== 現在のvisionOSのUIの不満点

#grid(
  columns: 3,
  gutter: 1em,
  [
    選択しづらいUIがいくつかある。

    例えば：
    - メニュー
    - アラート

    これらは、現状の不満点。
  ],
  image("images/photo_menu.jpeg"),
  image("images/photo_alert.jpeg"),
)

== 選択しづらい要因は？

メニューやアラートを選択しやすくするには、どのようなUIが良いのだろうか？

現状のセッションやガイドラインで言及されている注意点だけでは、不十分なのではないか？

visionOSはiOSの知見が活かされた優れたOSだが、空間入力の特性を考慮したUI設計はまだ改善点がありそう。

= 視線以外のフォーカス操作

== 視線以外のポインタコントロール

アクセシビリティ設定のポインタコントロールでは、視線以外の操作も選べる。

- 視線
- 頭
- 手首（左手または右手）
- 人差し指（左手または右手）

視線以外は比較的ポインタを操作しやすい。ただし、頭や手が疲れやすいので一長一短。

== トラックパッド・マウス

Magic TrackpadをApple Vision ProにBluetoothで接続できる（残念ながら手持ちがないので試していない）。

visionOS 2では、マウスもBluetoothで接続できる。

なお、ゲームコントローラも接続できるが、これは特定のアプリ内でのみ有効なようだ。

== Macのトラックパッド

Mac仮想ディスプレイの機能を使ってMacのディスプレイをApple Vision Proに表示しているとき、Macのトラックパッドを使って操作できる。

このとき、Macのディスプレイ画面の中だけかと思いきや、実はvisionOS全体をMacのトラックパッドで操作できる。

= まとめ

- 視線と注視によるフォーカス操作は意外と難しい
- 視線は動き回る
- UIの工夫が重要
- 視線以外のフォーカス操作もある
