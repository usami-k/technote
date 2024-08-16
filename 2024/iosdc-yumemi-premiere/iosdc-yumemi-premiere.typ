#import "@preview/touying:0.4.2": *
#let s = themes.metropolis.register(
  aspect-ratio: "16-9",
  footer: self => states.current-section-title,
)
#let s = (s.methods.info)(
  self: s,
  title: [パンフ記事＆ポスターセッション紹介],
  author: [宇佐見公輔],
  date: [2024-08-16],
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

- 宇佐見公輔

- 株式会社ゆめみ
  - iOSテックリード

- iOSDC Japan 2024
  - パンフレット記事
  - ポスターセッション

== 今日の内容

#touying-outline()

= スポンサー関連の活動紹介

== ゆめみのスポンサー記事

ゆめみのスポンサー記事：28〜35ページ

#grid(
  columns: 2,
  gutter: 1em,
  [
    *個人的なおすすめ*

    よくある1日のスケジュール（30〜31ページ）
  ],
  [
    #image("images/yumemi_schedule.png")
  ],
)

僕のスケジュールも掲載されています。

== ゆめみのスポンサーブース

ゆめみのスポンサーブース：
- 今年もクイズ企画あり
- オリジナルNFTをプレゼント

僕もキャラクター化されてNFTで配布されます。ぜひもらいに来てください。

= パンフレット記事の紹介

== 採択プロポーザル

#image("images/c40d5199-526b-4bf9-91d7-2a0bc609b305.png")

== 記事のPDFを公開中

#grid(
  columns: 2,
  gutter: 1em,
  [
    パンフレット記事のPDFをBOOTHで公開しました。

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

== 今後の展開

こういった情報は継続的に更新が必要そう。
すでに、次のような変化がある。

- swift-format
  - `apple/swift-format` から `swiftlang/swift-format` に移行
  - Xcode 16 に組み込まれる
- CocoaPods
  - メンテナンスモードに

Web上の記事の形にするべきかも。

= ポスターセッションの紹介

== 採択プロポーザル

#image("images/a28236ac-e8b0-4015-84e9-a0c9ac6670af.png")

== ポスターの概要

#link("https://fortee.jp/iosdc-japan-2024/proposal/a28236ac-e8b0-4015-84e9-a0c9ac6670af")[3次元回転とクォータニオン：iOSのAccelerateフレームワークでの実践]

3次元グラフィックスの基礎を知りたいiOSアプリ開発者向け

- クォータニオンの基礎
- simdモジュール
- 滑らかな回転アニメーションの実現
- SceneKitで回転を描画する実例

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

= まとめ

- パンフレット
  - スポンサー記事
  - 技術記事

- カンファレンス当日
  - スポンサーブース
  - ポスターセッション
