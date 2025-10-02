#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#show: metropolis-theme.with(aspect-ratio: "16-9", footer: utils.display-current-heading(level: 1), config-info(
  title: [記事『RealityKit の ECS パターン』の執筆で考えたこと],
  subtitle: [iOSDC Japan 2025 パンフ記事を眺める会],
  author: [宇佐見公輔],
  date: datetime(year: 2025, month: 9, day: 16),
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
  grid(
    rows: 2,
    gutter: 1em,
    [
      === 宇佐見公輔（うさみこうすけ）
      - I/O 8月号にWWDC25の記事を寄稿
      - iOSDCにパンフレット記事が採択
    ],
    rect(stroke: gray, image("images/iOSDC_RealityKit.png", width: 87%)),
  ),
  rect(stroke: gray, image("images/4868m.jpg")),
)

== 過去のパンフ記事 (1)

#grid(
  rows: 2,
  gutter: 1em,
  grid(
    columns: 2,
    gutter: 1em,
    rect(stroke: gray, image("images/iosdc2020-1.png", width: 87%)),
    rect(stroke: gray, image("images/iosdc2020-2.png", width: 87%)),
  ),
  grid(
    columns: 2,
    gutter: 1em,
    rect(stroke: gray, image("images/iosdc2021.png", width: 87%)),
    rect(stroke: gray, image("images/iosdc2022-1.png", width: 87%)),
  ),
)

== 過去のパンフ記事 (2)

#grid(
  rows: 2,
  gutter: 1em,
  grid(
    columns: 2,
    gutter: 1em,
    rect(stroke: gray, image("images/iosdc2022-2.png", width: 87%)),
    rect(stroke: gray, image("images/iosdc2023.png", width: 87%)),
  ),
  grid(
    columns: 2,
    gutter: 1em,
    rect(stroke: gray, image("images/iosdc2024.png", width: 87%)),
    [
      パンフレット記事が始まった2020年から毎年掲載。

      今年で8本目の掲載となった。
    ],
  ),
)

= 今年書いた記事の内容

== 今年書いた記事

#rect(stroke: gray, image("images/iOSDC_RealityKit.png"))

== 『RealityKit の ECS パターン』対象読者

- RealityKitに触れたことがない人への入門として
  - そもそもRealityKitってなに？

- 少し触れたことがある人への理解を深める一助として
  - エンティティとかコンポーネントとか雰囲気で使っている
  - ECSパターンをあまり知らない

== 『RealityKit の ECS パターン』見出し

- RealityKitの歴史
- ECSパターン
- RealityKitの基本
- RealityKitのエンティティ
- RealityKitのコンポーネント
- RealityKitのシステム
- RealityKitのECSの活用例
  - カスタムコンポーネントの実装
  - カスタムシステムの実装
  - 実装コードの全体

== 今日のLTでは

今日は、この記事の執筆にあたって考えたことを話します。

パンフレット記事を読んでみるきっかけになれば幸いです。

また、既に読んでいただいた方への理解の補助になれば幸いです。

= RealityKitを説明する

== RealityKitへの関心

ゲーム開発やARアプリ開発に関心がある人なら、RealityKitを知っているかも。

しかし一般的なアプリ開発者だと、RealityKit自体をあまり聞いたことがないのでは。

僕自身も、ARアプリ開発関連で少し知ってはいたけど、あまり詳しくはなかった。

そんなRealityKitが、Apple Vision Proの登場で気になる存在に。

== RealityKit自身の変遷

RealityKitは、登場当時から現在までに、立ち位置が変化している。

この変遷も、なじみのない人がとっつきづらい理由のひとつ。

- 当初は、ARアプリ開発をサポートするフレームワーク
- visionOS登場で、空間コンピューティングのフレームワーク
- 現在は、Appleプラットフォーム全体の3Dフレームワーク

RealityKitについてのシンプルな説明を一度書いておきたかった。

= ECSパターンを説明する

== ECSパターンへの関心

ゲーム開発に関心がある人なら、ECSパターンを知っているかも。一般的なアプリ開発者だと、知らないかも。

ゲーム開発の世界だと、アプリ開発でいうところのMVCパターンやMVVMパターンと同じくらいメジャーかもしれない？

（これはあまり感覚がわかってなくて適当に言ってる。さすがに適当すぎて記事には書かなかった）

== ECSパターンの学びかた

個人的には、RealityKitだけではECSパターンがあまりピンとこなかった、というのが正直なところ。

Rust言語にBevyというECSを採用したシンプルなゲーム開発フレームワークがある。土台がシンプルなぶん、こちらのほうが理解しやすかった。

（別途Rust言語の知識が必要にはなるので、一般におすすめできる方法ではない。あくまで自分の体験の話）

その体験をベースにして解説を考えた。

= 基本事項を丁寧に説明する

== サンプルを動かすだけでは満足できない

新しいフレームワークを理解するために、サンプルコードは大事。実際に自分で動かしてみるのが大事。

ただ、それだけでは満足できない。動いてはいるが、内容がわかっていない状態。

いきなり全部を理解するのは無理でも、全然わからないよりは、少しでもわかりたい。

== 公式ドキュメントを読んでも腑に落ちない

新しいフレームワークを理解するために、公式ドキュメントは大事。チュートリアルなどの記事が存在する場合もある。

実際、RealityKitは公式ドキュメントに解説記事がある。リファレンスもわりとちゃんと書かれている。

しかし、何も知らない状態で記事やリファレンスを読んでも、意外と難しくて理解しづらい。なかなかわかった気になれない。

== 自力で公式ドキュメントが読めるようになる

そこで、基本事項について、公式ドキュメントよりもさらに丁寧に説明する。

僕の記事を読んでも、RealityKitのすべてがわかるわけではない。しかし、入り口からはいり、少し足を踏み入れることはできる。そして、公式ドキュメントがある程度自力で読めるところまで導く。

そこから先は公式ドキュメントを読んでもらう。つまり、僕の記事の目標は「自力で公式ドキュメントが読めるようになる」こと。

= 基本事項を理解するためのサンプルコード

== 一般的なサンプルは難しめ

公式のサンプルコードは、自分で動かして体験してもらうことに重点が置かれている場合が多い。

その場合、サンプルコード自体はある程度難しくなる。フレームワークの理解には不要なコードがどうしても含まれてしまう。

公式はそれでもいいのだけど、僕の考える目標とはちょっと違う。基本事項を理解する助けになる、シンプルなサンプルコードがほしい。

== 基本事項を理解するためのサンプルコード

本当に基本事項だけで、それ以外の部分がほとんどないサンプルコードを作る。無駄をそぎ落とすことに労力をかける。

一方で、基本事項の説明は丁寧に書く。僕の記事はコードや文章に重複があって冗長な場合があるけど、これは省略しないほうがわかりやすいのではないかと考えて、意図的にやっている。

最後の1ページを費やしてコードの全体を見せている。この記事の内容がわかれば、コードの意味が全部読めるようになっているはず。

= まとめ

== まとめ

記事の執筆にあたって考えたこと。

- RealityKitを説明する
- ECSパターンを説明する
- 基本事項を丁寧に説明する
- 基本事項を理解するためのサンプルコード
