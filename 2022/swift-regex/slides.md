---
theme: apple-basic
canvasWidth: 720
highlighter: shiki
layout: intro
---

# Swift Regexの話

<div class="absolute bottom-10">
  <span class="font-700">
    宇佐見公輔 / 株式会社ゆめみ
  </span>
</div>

---

# 自己紹介

- 宇佐見公輔 / 株式会社ゆめみ
- iOSDC Japan 2022で記事（x2）を書き、トークをします。

<div class="container flex gap-4">
<div><img src="https://fortee.jp/iosdc-japan-2022/proposal/og-image/dfd8c56c-468a-4115-804c-d1ca103eed62.png" class="shadow" /></div>
<div><img src="https://fortee.jp/iosdc-japan-2022/proposal/og-image/c7306ef2-0e84-442d-a043-1a558403ad7d.png" class="shadow" /></div>
<div><img src="https://fortee.jp/iosdc-japan-2022/proposal/og-image/4f56de04-0d5c-49ba-b2f8-12b25e36ad32.png" class="shadow" /></div>
</div>

---

# Swift Regex

- Swift 5.7で、正規表現を扱う `Regex` 型が追加される。
- 従来もFoundationに `NSRegularExpression` が存在した。
- 新しい `Regex` はSwiftの標準ライブラリとして組み込まれる。

---

# Swift Regexの情報源

- [Meet Swift Regex](https://developer.apple.com/videos/play/wwdc2022/110357/)（WWDC22）
- [Swift Regex: Beyond the basics](https://developer.apple.com/videos/play/wwdc2022/110358/)（WWDC22）
- Xcode 14 beta Developer Documentation
- [SE-0350 Regex type and overview](https://github.com/apple/swift-evolution/blob/main/proposals/0350-regex-type-overview.md)
- [SE-0351 Regex builder DSL](https://github.com/apple/swift-evolution/blob/main/proposals/0351-regex-builder.md)
- [SE-0354 Regex literals](https://github.com/apple/swift-evolution/blob/main/proposals/0354-regex-literals.md)
- [SE-0355 Regex syntax](https://github.com/apple/swift-evolution/blob/main/proposals/0355-regex-syntax-run-time-construction.md)
- [SE-0357 Regex-powered algorithms](https://github.com/apple/swift-evolution/blob/main/proposals/0357-regex-string-processing-algorithms.md)

---

# Swift Regexの状況

- 現在のSwift 5.7はベータ版であり、未実装の機能がある。
  - セッションやドキュメントのコードが動くとは限らない。

- GitHubリポジトリ
  - [apple/swift-experimental-string-processing](https://github.com/apple/swift-experimental-string-processing/) リポジトリで開発。
  - その後 [apple/swift](https://github.com/apple/swift/) リポジトリにマージ。

---

# Regex型

```swift
let regex = try Regex(#"\d+"#)  // 補足： #"〜"# はSwiftの文字列リテラルの記法

"123".firstMatch(of: regex) // -> ["123"]
"a12b3".firstMatch(of: regex) // -> ["12"]
```

---

# Regexの生成方法

```swift
let regex = try Regex(#"\d+"#)

// Regexリテラル
let regex = /\d+/

// Regexビルダー
import RegexBuilder
let regex = OneOrMore(.digit)
```

---

# Regexリテラル

<Transform :scale="0.9">

```swift
// 通常の区切り文字
let regex = /[a-zA-Z][a-zA-Z0-9]*/

// 拡張区切り文字
let regex = #//usr/lib/.*/#

// 複数行リテラル
let regex = #/
  \d{2} / \d{2} / \d{4}
  \P{currencySymbol}+
  \p{currencySymbol}
/#
```

- 不正な正規表現ならばビルドエラーになる。
- シンタックスハイライトもサポートされる。

</Transform>

---

# リテラルによる値のキャプチャ

```swift
// キャプチャ
let regex = /user_id:\s*(\d+)/
let match = "user_id: 1234".wholeMatch(of: regex)
if let match {
    print(match.0) // -> "user_id: 1234"
    print(match.1) // -> "1234"
}

// 名前付きキャプチャ
let regex = /user_id:\s*(?<id>\d+)/
let match = "user_id: 1234".wholeMatch(of: regex)
if let match {
    print(match.id) // -> "1234"
}
```

---

# Swift Regexの正規表現シンタックス

- 正規表現は環境によって細かいシンタックスの差異がある。
- [SE-0355 Regex syntax](https://github.com/apple/swift-evolution/blob/main/proposals/0355-regex-syntax-run-time-construction.md)
- ベースの文法 : PCRE 2 / Oniguruma / ICU / .NET
- Unicodeをサポートする。

---

# Regexビルダー

```swift
import RegexBuilder

//let regex = /\d+/
let regex = OneOrMore(.digit)
let regex = Regex {
    OneOrMore(.digit)
}

//let regex = /user_id:\s*\d+/
let regex = Regex {
    "user_id:"
    ZeroOrMore(.whitespace)
    OneOrMore(.digit)
}
```

---

# ビルダーの中でリテラルを使う

```swift
import RegexBuilder

let regex = Regex {
    "Test Suite '"
    /[a-zA-Z][a-zA-Z0-9]*/
    "' "
    ChoiceOf {
        "started"
        "passed"
        "failed"
    }
    " at "
    OneOrMore(.any, .reluctant)
    Optionally(".")
}
```

---

# ビルダーによる値のキャプチャ

```swift
//let regex = /user_id:\s*(\d+)/
let regex = Regex {
    "user_id:"
    ZeroOrMore(.whitespace)
    Capture(OneOrMore(.digit))
}

let match = "user_id: 1234".wholeMatch(of: regex)
if let match {
    print(match.0) // -> "user_id: 1234"
    print(match.1) // -> "1234"
}
```

---

# TryCapture

```swift
let regex = Regex {
    "user_id:"
    ZeroOrMore(.whitespace)
    TryCapture {
        OneOrMore(.digit)
    } transform: {
        Int($0)
    }
}

let match = "user_id: 1234".wholeMatch(of: regex)
if let match {
    let (wholeMatch, id) = match.output
    print(id) // -> 1234
}
```

---

# Regexを使う

<img src="/SwiftRegex.jpeg" class="h-75" />

---

# Regex-powered algorithms

- 文字列処理にRegexサポートが追加される。

```swift
input.firstMatch(of: regex)
input.wholeMatch(of: regex)
input.prefixMatch(of: regex)

input.starts(with: regex)
input.replacing(regex, with: "456")
input.trimmingPrefix(regex)
input.split(by: /\s*,\s*/)
```

---

# switch文のサポート

```swift
switch "abc" {
case /\w+/:
    print("It's a word!")
}
```

- ただし、現状では未実装の様子。

（あまり分かってない。動いた人がいたら教えてください）

---

# Regex support in Foundation

- Foundationの既存のパーサーを流用できる。

```swift
import Foundation

let regex = Regex {
    One(.date(.numeric,
              locale: Locale(identifier: "ja_JP"),
              timeZone: TimeZone.current))
}
"2022/06/27".starts(with: regex) // -> true
```

---

# カスタムのパーサーを使う

```swift
import Darwin
struct CDoubleParser: CustomConsumingRegexComponent {
    typealias RegexOutput = Double

    func consuming(
        _ input: String,
        startingAt index: String.Index,
        in bounds: Range<String.Index>
    ) throws -> (upperBound: String.Index, output: Double)? {
      // ...
    }
}

let regex = Regex {
    CDoubleParser()
}
```

---

#  Swift Regexまとめ

- `Regex` 型
- Regexリテラル / Regexビルダー
- Regex-powered algorithms / Regex support in Foundation
