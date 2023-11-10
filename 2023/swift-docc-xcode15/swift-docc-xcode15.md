---
marp: true
headingDivider: 1
theme: gaia
class: invert
style: |
    section { font-family: '游教科書体 横用'; }
    h1 { font-family: '游ゴシック体'; }
paginate: true
footer: Xcode 15のDocCプレビュー機能の紹介
---

# Xcode 15の<br>DocCプレビュー機能の紹介
<!-- _class: lead invert -->

宇佐見公輔 / 株式会社ゆめみ
2023-11-08

# 自己紹介

* 宇佐見公輔（うさみこうすけ）
* 株式会社ゆめみ / iOSテックリード

![height:300](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/3622327/6aee6e0d-ecfc-4db3-9e5b-988981cfed9f.png) ![height:280](https://fortee.jp/iosdc-japan-2022/proposal/og-image/dfd8c56c-468a-4115-804c-d1ca103eed62.png)

# Swift-DocC

* Swiftのドキュメント作成ツール
    * APIドキュメント
    * チュートリアル
* 現在の公式ドキュメントの多くがSwift-DocCで作成されている
* Xcode 13に含まれる形でリリース（2021）

# Swift-DocCの更新 (1)

* Xcode 14に含まれる形でアップデート（2022）
    * Appプロジェクト対応
    * SwiftPMプラグイン対応
    * Objective-C対応
    * その他、細かな改善

# 余談

* SwiftPMプラグイン
    * Swiftパッケージには対応している
    * Appのマルチモジュール構成ではうまくいかない
        * 情報求む

# Swift-DocCの更新 (2)

* Xcode 15に含まれる形でアップデート（2023）
    * プレビュー機能
    * Swift extension対応
    * その他、細かな改善

# Xcode向けのサンプル

* SlothCreator: Building DocC Documentation in Xcode | Apple Developer Documentation
    * https://developer.apple.com/documentation/xcode/slothcreator_building_docc_documentation_in_xcode

# プレビュー機能（Xcode 15）

![height:400](xcode15-preview.png)

# 使いかた

Assistantウィンドウで「Documentation Preview」を選ぶ

![bg right:60% fit](menu.png)

# プレビュー機能のメリット

* 実際の出力と同じ見た目でプレビューできる
    * 他のエディターでもプレビューできるが見た目が変わる
* 固有の機能をプレビューできる
    * Markdown拡張ディレクティブ
    * チュートリアル

# 拡張ディレクティブ

* レイアウトのためのディレクティブがある（Swift 5.8以降）
    * `@Row` / `@Column`
    * `@TabNavigator`
    * `@Small`
    * `@Links`
* これらを使うときはプレビュー機能が便利

# @Row / @Column

```markdown
@Row {
   @Column {
      @Image(source: "icon-power-icon", alt: "A blue square containing a snowflake.") {
         Ice power
      }
   }

   @Column {
      @Image(source: "fire-power-icon", alt: "A red square containing a flame.") {
         Fire power
      }
   }
}
```

# @Row / @Column

![height:400](row.png)

# @TabNavigator

```markdown
@TabNavigator {
   @Tab("Powers") {
      ![A diagram with the five sloth power types.](sloth-powers)
   }

   @Tab("Excerise routines") {
      ![A sloth relaxing and enjoying a good book.](sloth-exercise)
   }

   @Tab("Hats") {
      ![A sloth discovering newfound confidence after donning a fedora.](sloth-hats)
   }
}
```

# @TabNavigator

![height:400](tab.png) ![height:400](tab2.png) 

# まとめ

* Swift-DocCは少しずつ進化している
* Xcodeのサポートも少しずつ増えている
* 機会があれば使ってみると良さそう
