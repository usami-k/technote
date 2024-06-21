---
marp: true
headingDivider: 1
theme: gaia
style: |
    section { font-family: 'YuKyokasho Yoko'; font-weight: bold; }
    h1 { font-family: 'YuGothic'; }
    code { font-family: '0xProto'; }
    pre { background-color: black; }
paginate: true
footer: SwiftのAccelerateフレームワーク
---

# 業務レベルのiOSアプリ開発で<br>どんな知識が求められるのか<br>考えてみた
<!-- _class: lead -->

宇佐見公輔
2024-06-20
YUMEMI.grow Mobile #14

# 自己紹介

- 株式会社ゆめみ / iOSテックリード
- 技術同人誌の出展：おもしろ同人誌バザール、技書博、技術書典

![width:170](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/2377560/8886f190-c479-4195-bc8a-bc6c05634fb8.png) ![width:170](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/2641333/5384ddb9-7f57-4aa1-aef9-4a339b3ed16f.png) ![width:170](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/3622327/6aee6e0d-ecfc-4db3-9e5b-988981cfed9f.png) ![width:170](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/4841376/255e28df-c614-4bce-9b1c-4bfe9bb0b5f0.png) ![width:170](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/5278270/e9ca14f6-6826-47de-859c-181bc0cc43f7.png) ![width:170](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/5668997/a9e084c1-05b0-4d98-8b2f-cbc2660dc807.png)

# 近況

- 進行中
  - iOSDC Japan 2024 向け原稿執筆とポスター作成
  - WWDC 24 セッション視聴
  - Apple Vision Pro 購入
- これらが同時並行で進むのは大変

# iOSDC Japan 2024 プロポーザル採択

- パンフレット原稿 / ポスターセッション

![width:560](https://fortee.jp/iosdc-japan-2024/proposal/og-image/c40d5199-526b-4bf9-91d7-2a0bc609b305.png) ![width:560](https://fortee.jp/iosdc-japan-2024/proposal/og-image/a28236ac-e8b0-4015-84e9-a0c9ac6670af.png)

# このプロポーザルの背景を話します

![width:650](https://fortee.jp/iosdc-japan-2024/proposal/og-image/c40d5199-526b-4bf9-91d7-2a0bc609b305.png)
https://fortee.jp/iosdc-japan-2024/proposal/c40d5199-526b-4bf9-91d7-2a0bc609b305

# なぜこのテーマを考えたのか
<!-- _class: lead invert -->

# プロポーザルの概要（前半）

iOSアプリ開発のチュートリアルや入門書は多く存在しており、学校の授業で扱われることもあります。しかし一方で、実際のアプリ開発の業務では、より多くの知識が求められます。このギャップに初学者がとまどうことも少なくありません。

この記事では、業務レベルのアプリ開発でどんな知識が求められ、どんなツールが使われているのかをざっくり紹介します。初学者に参考にしてもらうとともに、中級〜上級者にも開発環境を俯瞰的に捉える機会になればと考えています。

# なぜこのテーマを考えたのか (1)

- ゆめみの新卒採用（または業務未経験者の採用）
  - 簡単なアプリを作ることはできる
  - コーディングチェック試験で不合格になる率が高い
    - 採用側が求めているレベルに達していない

初学者とアプリ開発業務との間にギャップがありそう。

# なぜこのテーマを考えたのか (2)

- 他の開発経験がある人がiOSアプリ開発をはじめるとき
  - iOSアプリ開発の基本知識を手っ取り早く得たい
  - いまの開発現場で何が使われているのか知りたい

iOSアプリ開発者には当たり前のことも、他の人にはわからない。
こうした情報は変化も早く、情報収集が意外とむずかしい。

# なぜこのテーマを考えたのか (3)

- ゆめみのスキル星取表
  - 求められるスキルのリスト
  - 各自がそれぞれのスキルでどのくらいのレベルに達しているか
  - 給与自己決定のときに参考にするもののひとつ

スキル星取表に、どんなスキルがリストアップされているべきか。

# どんな内容を含めるのか
<!-- _class: lead invert -->

# プロポーザルの概要（後半）

・プログラミング言語、UIフレームワーク（UIKit、SwiftUI）
・IDE、ビルド設定、LinterやFormatter
・プロジェクト構成、パッケージ管理（SwiftPMなど）
・デザインや設計のガイドライン（HIGなど）
・API通信、プッシュ通知
・各種フレームワーク、データベース
・ローカライズ、アクセシビリティ
・テスト、CI（Xcode Cloudなど）、アプリ配布

# どんな内容を含めるのか (1)

初学者はどうしても品質が低め：品質を上げるための知識

- デザインや設計のガイドライン
  - ガイドラインを知って全体的な質を上げる
- LinterやFormatter
  - コードの品質を上げる

# どんな内容を含めるのか (2)

いまの開発現場で使われているもの

- プログラミング言語、UIフレームワーク（UIKit、SwiftUI）
  - 実際の案件でどのくらい使われているか
- 各種フレームワーク、データベース
  - どのようなものが使われているか

# どんな内容を含めるのか (3)

求められるスキルのリストに入れたいもの

- ローカライズ、アクセシビリティ
- プッシュ通知
- テスト、CI、アプリ配布
  - 知識や経験が求められる

# 内容の整理

業務で必要な知識をざっと俯瞰できている内容だと良さげ

- プロジェクト構成やパッケージ管理などもおさえておきたい
  - 初学者が知っていそうなことでも含めておく

# まとめ
<!-- _class: lead invert -->

# まとめ

- 業務レベルのiOSアプリ開発でどんな知識が求められるのか
- 俯瞰的にまとめているものが意外とないので考えてみた
- パンフレット記事として書いてみた

パンフレットができたら感想がもらえると嬉しいです
