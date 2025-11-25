#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#show: metropolis-theme.with(aspect-ratio: "16-9", footer: utils.display-current-heading(level: 1), config-info(
  title: [iOSの設計にMVVMを使わない理由],
  subtitle: [YUMEMI.grow Mobile \#25],
  author: [宇佐見公輔],
  date: datetime(year: 2025, month: 11, day: 25),
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
  [
    === 宇佐見公輔（うさみこうすけ）
    - iOSテックリード

    === 最近の執筆
    - 『組版ソフトウェアTypstを活用しよう』#text(size: 18pt)[（新刊：技書博12 / 技術書典19）]
    - 「パズルを解くためのコミュテーター」#text(size: 18pt)[（寄稿：月刊I/O 2025年11月号）]

    iOS関連もいずれ書く予定です。
  ],
  rect(stroke: gray, image("images/BookTypst.png")),
)

= 今日のテーマ：iOSアプリ開発におけるMVVM

== iOSアプリ開発におけるMVVM

=== MVVMとは

- MVVM = Model-View-ViewModel
- iOSアプリ開発では10年くらい前に人気を集めた設計
- 最近は使われなくなっている

=== ゆめみの採用担当において

- 採用課題やポートフォリオなどで、MVVM使用事例がまだある
- しかし妥当な選択とは思えない

== そこで今日の話は

- なぜiOSアプリ開発でMVVMが人気を集めたか
- なぜ最近は使われなくなっているか

当時の自分自身もその流れの中にいたので、改めて振り返ります。

=== 注意事項

- 今日の話はあくまで*個人的な*見解です
- 事実と異なる点などあれば、ご指摘いただけると助かります
- 別の見解などもあれば、参考にします

= MVVMが人気だった理由

== 当時の課題

MVVMが人気を集めたのは10年くらい前のことです。

- 当時の主流はMVCアーキテクチャ
  - MVC = Model-View-Controller

- UIKitによるViewControllerという概念は一定の成功をおさめた

- しかしViewControllerの肥大化が課題となっていた

== MVVMの登場

- MVVMはもともとWindows / C\#の世界で登場した
  - MVVM = Model-View-ViewModel

- それを参考に、iOSアプリ開発者たちがMVVMを採用しだした
  - ただし、iOS向けにアレンジされた形になることが多かった
  - そのため、ひとくちにMVVMといっても界隈によって話の解釈が違ってしまうので注意

== MVVMの利点

- ViewControllerからロジックを分離してViewModelへ
  - ViewControllerの肥大化の解決

- ViewとModelのデータバインディング
  - RxSwiftとの相性の良さ

- テスタビリティの向上
  - ViewModelの単体テストが可能

= MVVMの問題点

== ViewModelの肥大化

- ViewControllerの代わりにViewModelが肥大化
  - ViewControllerの役割の一部の肩代わりはできた
  - しかし、肥大化箇所が移動しただけで根本的な改善にはならず

- ViewModelの責務が曖昧になりがち
  - ViewControllerの責務が曖昧だったのと同様の問題

== 過剰なReactiveコード

- RxSwiftによる実装が技巧的になりがち
  - Rxでスマートな実装ができるが、やりすぎは良くない
  - 多くのボイラープレートが発生

- データフローが複雑化しがち
  - 複数のストリームの結合が絡むと、複雑になりやすい

== ViewModelのテストが複雑に

- ViewModelの単体テストは、実際に書いてみると複雑
  - ViewModelが肥大化していることも関連
  - テスト用のMockがたくさん必要

== ライフサイクルの扱いが複雑に

- UIKitのライフサイクルはViewControllerの役割
  - ViewModelではライフサイクルを意識しないですむ想定

- しかし実際に書いてみると、そううまくはいかない
  - ViewModelでもライフサイクルを意識した実装が必要になる
  - ライフサイクルの二重管理状態に

= SwiftUI登場による変化

== SwiftUIの登場

- MVVMは、問題点はありつつも標準的な設計のひとつ

- しかし、SwiftUIの登場で話が変わってきた

- MVVMの利点が、SwiftUIによって別の形で解決される

== データバインディングの仕組みがある

- データバインディングの仕組みがSwiftUIフレームワークにある
  - Observationなど

- データバインディングをRxSwiftに頼る必要がない
  - サードパーティーライブラリへの依存の解消

== Viewが肥大化しにくい

- ViewControllerやViewModelが肥大化していたのは次の理由
  - 責務があいまいになりやすい
  - データバインディングが冗長になりやすい

- SwiftUIのViewは責務がわかりやすい
  - プレゼンテーションの実装に集中しやすい
  - ロジックも書けてしまうけど、分離はしやすい

- データバインディングもシンプルになった

== ViewModelは不要に

- Viewの肥大化の解決

- データバインディング手法の解決

これらにより、ViewModelの利点の多くが不要になり、むしろ冗長な存在になった。

SwiftUI時代にMVVMは適切なアーキテクチャとはいえない。

= ではどうするのか？

== どんな設計がよいか

ここでは、どれが良いかの結論は明言しないでおきます。

ただ、いったんViewModelという考えを手放してみると良いです。

- シンプルなModelとViewの構造でも十分足りる
  - ModelとViewの分離は意識しておく

- PointFreeのTCAは解決案のひとつ
  - ただし、これも万能ではない
