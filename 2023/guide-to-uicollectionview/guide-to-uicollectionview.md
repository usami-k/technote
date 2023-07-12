---
marp: true
headingDivider: 1
theme: gaia
class: invert
style: |
    section { font-family: '游教科書体 横用'; }
    h1 { font-family: '游ゴシック体'; }
paginate: true
footer: これからUICollectionViewを実践活用する人のためのガイド
---

# これからUICollectionViewを<br>実践活用する人のためのガイド
<!-- _class: lead invert -->

宇佐見公輔 / 株式会社ゆめみ
2023-07-12

# 自己紹介

* 宇佐見公輔（うさみこうすけ）
* 株式会社ゆめみ / iOSテックリード
* 大阪在住
* iOSDC Japan 2023
    * パンフレット記事採択 → 入稿済
    * 9月に現地参加予定

![bg fit right:40%](https://fortee.jp/iosdc-japan-2023/proposal/og-image/e64d6e4e-8c54-4eac-9880-80fe2e5527cd.png)

# 今日の内容

UICollectionViewの学びかたを整理して話します

（ポスターセッションで応募しましたが、残念ながら不採択でした）

![bg fit right:40%](https://fortee.jp/iosdc-japan-2023/proposal/og-image/0447d457-dd4c-4a9d-8fb1-f17b568ca128.png)

# UICollectionViewとは

* iOS 6で登場
* グリッド表示のUIコンポーネント
* コンテンツの配置が柔軟に行える
* その柔軟性ゆえに実装の難易度は高め
* iOS 13〜14で、モダンなAPI群が追加された

![bg fit right:35%](https://docs-assets.developer.apple.com/published/2feb3d1b37/rendered2x-1627683362.png)

# 構成要素：UITableViewの場合

* Data Source
* Cell

画面に表示されるぶんだけのデータを取得してセルを生成する仕組み

# 構成要素：UICollectionView

* Layout
* Data Source
* Cell

UITableViewに加えて、グリッド表示などのレイアウトが追加

# 実装のための基本

* Layout
    * `UICollectionViewLayout` クラスのサブクラス
* Data Source
    * `UICollectionViewDataSource` プロトコルの実装クラス
* Cell
    * `UICollectionViewCell` クラスのサブクラス

# レイアウト

* `UICollectionViewLayout` クラスのサブクラス
    * ただし、自前で実装するのは大変
* 標準で `UICollectionViewCompositionalLayout` が用意されている
    * これでほとんどのレイアウトは実現できる（iOS 13以降）
* 参考：以前は `UICollectionViewFlowLayout` が標準だった
    * 現在も使えるがオススメしない

# データソース

* `UICollectionViewDataSource` プロトコルの実装クラス
    * 自前で実装するのも難しくない
* 標準で `UICollectionViewDiffableDataSource` が用意されている
    * 差分更新の仕組みがあって高機能（iOS 13以降）
    * ただし、使うために学ぶことが少し多い

# セル

* `UICollectionViewCell` クラスのサブクラス
    * 自前で実装するのも難しくはない
    * セルの登録・再利用の仕組みも知る必要がある
* `UIContentView` と `UIContentConfiguration` が用意されている
    * セルの実装を安全にする（iOS 14以降）
* `CellRegistration` が用意されている
    * セルの登録・再利用の仕組みを安全にする（iOS 14以降）

# 学ぶ順番：最初のステップ

* まずは最小限の実装でUICollectionViewを動かす
    * 動かすために必要な要素を少ない労力で揃える

# 学ぶ順番：最初のステップ

* Layout
    * `UICollectionViewCompositionalLayout` の最小限の利用
* Data Source
    * 最初は `UICollectionViewDataSource` プロトコルを自前実装するのがわかりやすい
* Cell
    * 最初は `UICollectionViewCell` のサブクラスを自前実装するのがわかりやすい

# 学ぶ順番：次のステップ (1)

* Data Source
    * `UICollectionViewDataSource` プロトコルの自前実装をやめて、`UICollectionViewDiffableDataSource` を使う
    * Diffable Data Sourceに必要な概念を学ぶ
        * `Identifiable` / `Hashable` / `Equatable`
        * スナップショット

# 学ぶ順番：次のステップ (2)

* Cell
    * セルの登録・再利用に `CellRegistration` を使う
    * セルの実装に `UIContentView` と `UIContentConfiguration` を使う

# 学ぶ順番：次のステップ (3)

* Layout
    * `UICollectionViewCompositionalLayout` をより詳しく学ぶ
        * グループのネスト
        * セクション、アイテムの装飾

# 宣伝

* UICollectionViewの本を書きました
* BOOTH、Zennなどで販売中
* 書ききれなかった内容もあるので、続編を検討中・・・

![bg 80% right:40%](https://s2.booth.pm/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/4841376/255e28df-c614-4bce-9b1c-4bfe9bb0b5f0_base_resized.jpg)
