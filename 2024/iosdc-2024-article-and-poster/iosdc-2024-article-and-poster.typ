#import "@preview/touying:0.4.2": *
#let s = themes.metropolis.register(
  aspect-ratio: "16-9",
  footer: self => states.current-section-title,
)
#let s = (s.methods.info)(
  self: s,
  title: [ポスターセッション紹介：クォータニオンをiOSのsimdモジュールで扱う],
  author: [宇佐見公輔],
  date: [2024-08-14],
  institution: [株式会社ゆめみ],
)
#let (init, slides, touying-outline, alert, speaker-note) = utils.methods(s)
#show: init
#set text(font: "IBM Plex Sans JP", size: 26pt)
#show math.equation: set text(font: "STIX Two Math")
#show raw: set text(font: "0xProto")
#show link: it => underline(text(blue, it))
#let (slide, empty-slide, title-slide, new-section-slide, focus-slide) = utils.slides(s)
#show: slides.with(outline-slide: false)
#let ii = $mono(i)$
#let jj = $mono(j)$
#let kk = $mono(k)$

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

= パンフレット記事の紹介

== 記事のPDFを公開中

#grid(
  columns: 2,
  gutter: 1em,
  [
    パンフレット記事のPDFをBOOTHで公開した。

    #link("https://type-d4-lab.booth.pm/items/5973097")[iOSアプリ開発のいま：基礎知識から業務レベルのツールまで - Type D4 Lab - BOOTH]
  ],
  [
    #image("images/acd5e385-e422-4b0c-b04c-2dff191f80cc.png")
  ],
)

== 記事の内容

エンジニアの採用に関わることが多く、こういう情報がまとまっていてほしいと感じたので書いてみた。

- 業務レベルのアプリ開発でどんな知識が求められるか
- 主にiOSアプリ開発を仕事にしたい初学者向け

今後、内容をもっとブラッシュアップしていきたいので、感想や意見をフィードバックしてもらえると嬉しいです！

== パンフレット記事の制作

今回、パンフレット記事の制作では、江本さんが作成された Vivliostyle のテンプレートを活用した。

A4サイズのパンフレット向けのレイアウトは意外と難しいので、テンプレートを活用するのが良さげ。

（全員が同じレイアウトである必要は全然ないけど、一定以上の品質はほしい気持ち）

= ポスターセッションの紹介

== ポスターの概要

#link("https://fortee.jp/iosdc-japan-2024/proposal/a28236ac-e8b0-4015-84e9-a0c9ac6670af")[3次元回転とクォータニオン：iOSのAccelerateフレームワークでの実践]

3次元グラフィックスの基礎を知りたいiOSアプリ開発者向け

- クォータニオンの基礎
- simdモジュール
- 滑らかな回転アニメーションの実現
- SceneKitで回転を描画する実例

== この内容を扱った動機

次のような点に普段から関心があり、まとまった形のアウトプットにしてみたいと感じた。

- 数学的な側面
  - クォータニオン（四元数）
  - 3次元回転

- iOS的な側面
  - Accelarateフレームワーク
  - 3次元グラフィックス

= ポスターの内容をざっくりと

== クォータニオン

複素数を拡張した数。虚数単位が3つある。

$ x_0 + x_1 ii + x_2 jj + x_3 kk $
$ ii^2 = jj^2 = kk^2 = -1 $
$ ii jj = -jj ii = kk quad jj kk = -kk jj = ii quad kk ii = -ii kk = jj $

- 複素数を使うと、2次元平面上の回転を記述できる
- クォータニオンを使うと、3次元空間上の回転を記述できる

== Accelarateフレームワークとsimdモジュール

Accelarate：Appleが提供する数値計算ライブラリ群

- 機械学習：BNNS
- 画像処理：vImage
- デジタル信号処理：vDSP
- ベクトルに対する関数演算：vForce
- 線型代数：BLAS / LAPACK / Sparse Solvers

simdモジュール：Accelerateの一部
- ベクトルや行列の演算のための型と関数
- CPUのベクトル処理機能を使って効率的な演算

== 滑らかな回転アニメーションの実現

3次元回転の処理は、線型代数の行列計算でも書ける。

しかし、クォータニオンを使うと、

- 回転の補間計算が容易になる
- つまり、回転の途中経過の計算が容易になる

そのおかげで、回転アニメーションの途中経過が描画できる。

実際にSceneKitで実装してみると視覚的にわかりやすい。

= ポスターの制作

== ポスターの形式

次のどちらかが選べる。

- A4サイズのスライド10枚（原稿提出）
- A0サイズのポスター1枚（自力で持ち込み）

前者は普段のトークスライドと近い感じで作れる。

後者は学会のポスター発表と同様の感じ。

== A0サイズのポスター

今回はせっかくの機会なので、A0サイズのポスターに挑戦。

ただ、実のところポスター発表は初めてなので、作り方から調べることに。

データ制作は、A0サイズに対応したツールは少なく、AdobeやAffinityのツール群を使うのが一般的か。

今回は、Typstを使って制作してみた。
（TypstはLaTeXと同様の組版ソフトで、最近注目されている）

== ポスターの印刷と運搬

ポスターを大阪から会場までどうやって運搬して持ち込むか？

- 現地に近い場所で印刷して、そのまま会場まで運ぶ
- 紙で印刷しておいて、丸めるまたは折りたたんで持ち込む
- 布で印刷しておいて、折りたたんで持ち込む

まだ検討中。

= まとめ

iOSDC当日は、ポスターもぜひ見に来てください。

パンフレット記事やポスターについて、感想や質問があれば直接話しかけてもらえればと思います。
