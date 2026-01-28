#import "@preview/touying:0.6.1": *
#import themes.stargazer: *
#show: stargazer-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: "iOSアプリ開発のPathway",
    author: "宇佐見公輔",
    date: datetime(year: 2026, month: 1, day: 28),
    logo: image("images/Profile_NFT.jpeg"),
  ),
)
#set text(font: ("0xProto", "BIZ UDGothic"))

#title-slide()

== 自己紹介

#grid(
  columns: 2,
  gutter: 2em,
  [
    === 宇佐見公輔（うさみこうすけ）
    - iOSアプリエンジニア

    - アクセンチュア株式会社／ゆめみ
      - 株式会社ゆめみから転籍
      - Song部門所属
        - コンサルのS&C部門や技術のTechnology部門とはまた別のクリエイティブ集団
  ],
  [
    === 昨年の技術同人誌
    #grid(
      columns: 2,
      gutter: 1em,
      rect(stroke: gray, image("images/BookTesting.png")), rect(stroke: gray, image("images/BookTypst.png")),
    )
  ],
)

#outline-slide()

= iOSアプリ開発を学ぶ

== 昨年11月の技術書典19にて

- 個人サークルでブース出展しました

=== 来場者との対話
- 「iOSアプリ開発に関する出展が少ない」
  - 言われてみれば、あまり出展されていない

- 「iOSアプリ開発のための参考書が少ない」
  - 商業誌も含めて、本が少なくなってきている

== 開発を学ぶ意味

- コーディングAIの普及
  - Claude Code、Codex、Geminiなど

- 開発を知っていると、AIをより効果的に活用できる
  - 少しの学びで大きな成果につながる
  - 難しいところはAIの助けを借りる
  - いま開発を学ぶのはコスパが良い

== iOSアプリ初学者向けの情報源

- 各社が公開しているiOS研修資料
  - 実践的な内容で良いものが多い
  - メンターと共に学ぶと良い

- Zennの本、Qiitaの記事
  - 良いものが少しずつ出てきている

== Appleのドキュメント

- WWDCセッション動画
  - 初学者向けの情報源ではない

- チュートリアル、ガイド、リファレンス
  - 初学者に有益なものも多いが、量が多く、どこから読むか難しい

- Pathway
  - どこから読めば良いか教えてくれるコレクション

= Pathwayとは

== Pathwayとは

- https://developer.apple.com/jp/pathways/
- Apple Developerサイトにある公式の開発ガイド
- 2024年5月に公開、2025年に更新

#align(center, image("images/Pathway.png", height: 60%))

== Pathwayの構成

- Apple Developer
- デザイン
- App Store

#grid(
  columns: (1fr, 1fr),
  gutter: 2em,
  [
    === Appleプラットフォーム
    - iOS
    - iPadOS
    - macOS
    - tvOS
    - visionOS
    - watchOS
  ],
  [
    === ツール、テクノロジーなど
    - Swift
    - SwiftUI
    - ゲーム
    - Apple Intelligence
    - 機械学習
    - エンタープライズ
  ],
)

== Apple Developer Pathway

開発の概略をまとめたコレクションページ。

- Apple Accountにサインイン
- Swift Playground、Xcode、Swift、SwiftUIを活用する
- プロトタイプを構築する
- 見た目の美しさや優れた使用感の実現
- ビジネスモデルを選択する
- Apple Developer Programに登録する
- 署名証明書について確認する
- プロビジョニングプロファイルの役割を理解する
- ユーザーにアプリやゲームを紹介する
- 知識を深める

== Design Pathway

アプリデザインに関するコレクションページ。

- デザインの構成要素を学ぶ
- HIGを参考にする
- ツールを揃える
- プロトタイプを作成する
- デベロッパコミュニティからインスピレーションを得る
- 知識を深める

== App Store Pathway

アプリ配信に関するコレクションページ。

- App Storeの概要
- App Reviewガイドラインの理解
- ビジネスモデルの選⁠択
- アプリ内課金の設定
- アプリやゲームのテ⁠ス⁠ト
- アプリやゲームの配⁠信
- 成果の測定
- 知識を深める

= iOSアプリ開発のためのPathway

== iOSアプリ開発のためのPathwayはどれ

iOSアプリ開発についてもっと詳しく知りたい場合のPathway。

=== Appleプラットフォーム
- iOS

=== ツール、テクノロジーなど
- SwiftUI

== iOS Pathway

iOSアプリ開発に焦点を当てたコレクションページ。

- iOSについて
- ツールを揃える
- デザインの追求
- ベストプラクティスの採用
- 複数のAppleプラットフォーム向けの構築
- アプリの配信
- 知識を深める

== iOS Pathway : ツールを揃える

- Xcode

- Swift
  - → Develop in Swift Tutorials

- SwiftUI
  - → SwiftUI Tutorials

== SwiftUI Pathway

SwiftUIに焦点を当てたコレクションページ。

- SwiftUIの概要
- 最適なビューの構築
- デザインへの体系的なアプローチ
- ナビゲーションのデザインと構築
- データモデルの理解
- 知識を深める

各種のSwiftUIチュートリアルへリンクがある。実践的なコーディングの理解。

= Pathwayの活用

== Pathwayの活用ポイント

- PathwayはApple公式の開発ガイド

- Pathwayは包括的なコレクション
  - アプリ開発の全体像を把握するために役立つ
  - 入門以後も、ときどき戻ってきて全体像を確認するとよい

- 具体的な開発はチュートリアルで学ぶ
  - Pathwayから各種チュートリアルへリンクがある
