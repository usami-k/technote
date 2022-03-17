---
theme: apple-basic
layout: intro
---

# Swift 5.6で使えるようになった<br>swift-docc-pluginを試してみる

<div class="absolute bottom-10">
  <span class="font-700">
    宇佐見公輔 / 株式会社ゆめみ
  </span>
</div>

---

# 自己紹介

* 宇佐見 公輔（うさみこうすけ） / @usamik26
* 株式会社ゆめみ / iOSテックリード
* 最近、本を書いたりiOSの記事を寄稿したりしています。

<div class="container flex gap-4">
<div><img src="https://usami-k.github.io/techbook/N01519.jpeg" class="h-70 shadow" /></div>
<div><img src="https://usami-k.github.io/techbook/web+db_press_126.jpg" class="h-70 shadow" /></div>
<div><img src="https://usami-k.github.io/techbook/BookDocC.png" class="h-70 shadow" /></div>
</div>

---
layout: section
---

# Swift-DocC

---

# Swift-DocC

* Swift-DocC : Swiftのドキュメント生成ツール、オープンソースで公開されている
* CLIの `docc` コマンドで利用できる、またXcodeに標準で組み込まれている

<v-click>

* ドキュメントコメントの例：

<div class="grid grid-cols-[60%,40%] gap-4">
<div>

```swift
/// 用意された特製のナマケモノ向け食糧を食べる。
///
/// - Parameters:
///   - food: ナマケモノが食べる食糧。
///   - quantity: ナマケモノが食べる食糧の数。
/// - Returns: 食べた後のナマケモノのエネルギー量。
mutating public func eat(_ food: Food, quantity: Int = 1) -> Int {
    energyLevel += food.energy * quantity
    return energyLevel
}
```

</div>
<div><img src="/ref_Parameters.png" /></div>
</div>

</v-click>

---
layout: section
---

# Swift 5.6

---

# Swift 5.6

* 2022-03-15（日本時間）リリース
* 同じ日にリリースされたXcode 13.3に付属
* 言語としてのアップデートもあるが、個人的には Swift Package Manager の機能が気になる

<v-click>

## Swift Package Manager

* [SwiftPM 5.6 Release Notes](https://github.com/apple/swift-package-manager/blob/main/Documentation/ReleaseNotes/5.6.md)
* SwiftPMにプラグイン機能が新しく追加された
* SE-0303 ビルドツールプラグイン：`swift build` のとき外部ツールを実行できる
* SE-0332 コマンドプラグイン：`swift package` コマンドを拡張して外部ツールを実行できる

</v-click>

---

# ビルドツールプラグイン

* `swift build` のとき外部ツールを実行できる
* `Package.swift` で使いたいプラグインを指定すると自動的に実行される

<v-click>

## Examples

* SE-0303では、以下の例が挙げられている
* SwiftGenでソースコードを生成する
* SwiftProtobufでソースコードを生成する

</v-click>

---

# コマンドプラグイン

* `swift package` コマンドを拡張して外部ツールを実行できる
* `Package.swift` で使いたいプラグインを指定するとコマンドが拡張される
* コマンドは `swift package do-something` という形式になる

<v-click>

## Examples

* SE-0332では、以下の例が挙げられている
* ドキュメント生成：`swift package generate-documentation`
* ソースコード整形：`swift package format-source-code`
* Zipアーカイブ作成：`swift package create-distribution-archive`

</v-click>

---

# 注意点

* ビルドツールプラグインもコマンドプラグインも、プラグインの準備が必要
* 既に用意されていれば、それを使うだけでいいので簡単
* 用意されていなければ、自分でプラグインを記述する必要がある（ちょっと面倒）

---
layout: section
---

# swift-docc-plugin

---

# swift-docc-plugin

* SwiftPMからSwift-DocCを実行できるコマンドプラグイン
* Swift 5.6と同じ日にバージョン1.0.0がリリース
* [apple/swift-docc-plugin](https://github.com/apple/swift-docc-plugin)
* [SwiftDocCPlugin | Documentation](https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/)

<v-click>

## コマンドプラグインで追加されるコマンド

* `swift package generate-documentation`
* `swift package preview-documentation`

</v-click>

---

# プラグインの追加

* `Package.swift` に以下を記述

```swift
let package = Package(
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    ],
    targets: [
        // targets
    ]
)
```

* これで拡張されたコマンドが使えるようになる

---

# swift package generate-documentation

* `.doccarchive` を生成する
* Xcodeでドキュメントを見ることができる

<img src="/SwiftDocCPlugin_doccarchive.png" />

---

# --transform-for-static-hosting オプション

* `swift package generate-documentation --transform-for-static-hosting` 
* Web公開用のドキュメントを生成する
* GitHub Pagesでホスティングできる

---

# swift package preview-documentation

* ローカルでプレビュー用のサーバが起動する
* ブラウザでドキュメントを見ることができる

---

# まとめ

* SwiftPM形式のライブラリやツールでもSwift-DocCが使いやすくなった
* ドキュメントをWeb公開する方法もサポートされた
