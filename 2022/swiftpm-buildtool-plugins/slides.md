---
theme: apple-basic
layout: intro
---

# SwiftPMのプラグイン機能を<br>活用する

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

# Swift Package Managerの<br>更新

---

# Swift 5.6リリース

* 2022-03-15（日本時間）リリース
* 同じ日にリリースされたXcode 13.3に付属
* 言語機能の更新もあったが、Swift Package Managerの更新もあった

<v-click>

## Swift Package Manager

* [SwiftPM 5.6 Release Notes](https://github.com/apple/swift-package-manager/blob/main/Documentation/ReleaseNotes/5.6.md)
* SwiftPMにプラグイン機能が新しく追加された
* SE-0303 ビルドツールプラグイン：`swift build` のとき外部ツールを実行できる
* SE-0332 コマンドプラグイン：`swift package` コマンドを拡張して外部ツールを実行できる

</v-click>

---

# コマンドプラグイン

* `swift package` コマンドを拡張して外部ツールを実行できる
* `Package.swift` で使いたいプラグインを指定するとコマンドが拡張される
* コマンドは `swift package do-something` という形式になる

<v-click>

## Examples

* [apple/swift-docc-plugin](https://github.com/apple/swift-docc-plugin)
* これを導入すると以下のコマンドが使えるようになる
* `swift package generate-documentation`
* `swift package preview-documentation`
* 先週のSwift愛好会で話しました（[Swift 5.6 で使えるようになった swift-docc-plugin を試してみる](https://speakerdeck.com/usamik26/try-swift-docc-plugin)）

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
layout: section
---

# ビルドツールプラグインを<br>試してみる

---

# ビルドツールプラグインを試してみる

* [juozasvalancius/ExampleSPMProjectWithSwiftLint](https://github.com/juozasvalancius/ExampleSPMProjectWithSwiftLint)
* SwiftLintプラグインのサンプル
* この方は、SwiftPMプラグイン対応のためにSwiftLintにもコミットしている

<v-click>

## Xcodeプロジェクトに適用してみた

* [usami-k/XcodeSwiftPMSample](https://github.com/usami-k/XcodeSwiftPMSample)

</v-click>

---

# XcodeプロジェクトとSwiftPM

* XcodeプロジェクトとSwiftPMを組み合わせて使う
* 最近、見かけることが増えてきたプロジェクト構成

<v-click>

## プロジェクト構成

* [usami-k/XcodeSwiftPMSample](https://github.com/usami-k/XcodeSwiftPMSample)
* アプリのXcodeプロジェクト（`Hello.xcodeproj`）には、必要最小限のものだけ入れる。
* アプリの実装コードは、Swiftパッケージ（`AppFeature`、`Core`）に入れる。
* `Hello.xcodeproj` でアプリに `AppFeature` パッケージをリンクする。

</v-click>

---

# ビルド時の処理の定義を改善する

* ビルド時に何か処理を行いたいときはXcodeのビルドスクリプト機能を使っていた
* SwiftPMにビルドスクリプト機能がなかったため

<v-click>

## ビルドツールプラグインの活用

* SwiftPMのビルドツールプラグインを使う
* Xcodeプロジェクトを編集せず、SwiftPMの機能でビルド時の処理を定義できる

</v-click>

---

# ビルドツールプラグインの導入

* `Package.swift` の記述
* `SwiftLintXcode` がビルドツールプラグイン

```swift
targets: [
    .binaryTarget(
        name: "SwiftLintBinary",
        url: "https://github.com/juozasvalancius/SwiftLint/releases/download/spm-accommodation/SwiftLintBinary-macos.artifactbundle.zip",
        checksum: "cdc36c26225fba80efc3ac2e67c2e3c3f54937145869ea5dbcaa234e57fc3724"
    ),
    .plugin(
        name: "SwiftLintXcode",
        capability: .buildTool(),
        dependencies: ["SwiftLintBinary"]
    ),
    .target(
        name: "AppFeature",
        dependencies: [
            "Core"
        ],
        plugins: ["SwiftLintXcode"]),
]
```

---

# ビルド時の処理の記述

* `Plugins` フォルダ内の Swift コードで記述する

```swift
import PackagePlugin

@main
struct SwiftLintPlugins: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        return [
            .buildCommand(
                displayName: "Linting \(target.name)",
                executable: try context.tool(named: "swiftlint").path,
                arguments: [
                    "lint",
                    "--in-process-sourcekit",
                    "--path",
                    target.directory.string
                ],
                environment: [:]
            )
        ]
    }
}
```

---

# まとめ

* Xcodeのビルドスクリプト機能をSwiftPMのビルドツールプラグインで置き換えが可能になった
* Xcodeプロジェクトへの依存を減らし、SwiftPMを活用することができる
