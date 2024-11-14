#import "@preview/touying:0.5.2": *
#import themes.metropolis: *
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: utils.display-current-heading(level: 1),
  config-info(
    title: [Swift Testingの\ パラメトライズテスト],
    author: [宇佐見公輔],
    date: [2024-11-14],
    institution: [株式会社ゆめみ],
    logo: [#image("images/Profile_NFT.jpeg", height: 35%)],
  ),
)
#set text(font: ("0xProto", "Explex35"), size: 26pt)
#show math.equation: set text(font: "STIX Two Math")
#show raw: set text(font: "0xProto")
#show link: it => underline(text(blue, it))
#title-slide()

== 自己紹介

- 宇佐見公輔
  - 株式会社ゆめみ iOSテックリード

#grid(
  columns: 3,
  gutter: 1em,
  [#rect(image("images/yumemi-daigirin-24-2.png", height: 70%))],
  [
    ← ゆめみ大技林\ 技術書典17で頒布中

    #align(right)[月刊I/O →\ 最近いくつか寄稿]
  ],
  [#rect(image("images/io-2024-09.jpg", height: 70%))],
)

= Swift Testingとは

Swift用の単体テストフレームワーク

- Swift 6、Xcode 16に統合された
- 従来のXCTestに比べて、Swiftの機能をより活用
- Swift TestingとXCTestは同じプロジェクトで混在可
  - そのため、少しずつ移行できる

== Swift Testingの構成要素

- テスト関数
  - `@Test` 属性
- 期待値の確認
  - `#expect` マクロ
- テストスイート
  - `@Suite` 属性
- トレイト
  - `TestTrait` / `SuiteTrait`

= リファレンス

#link("https://developer.apple.com/documentation/testing")[Swift Testing | Apple Developer Documentation]

- ドキュメントは結構ある
- ただ、マクロのリファレンスなどはやや読みづらい
- そこで解説本を執筆中
  - 技術書典17に間に合わせたかったけど・・・

== 実際のリファレンスの例

```swift
@freestanding(expression)
macro expect(
    _ condition: Bool,
    _ comment: @autoclosure () -> Comment? = nil,
    sourceLocation: SourceLocation = #_sourceLocation
)
```

実際の使い方

```swift
#expect(library.count == 1)
```

= テスト関数

```swift
import XCTest
class MySimpleLibrarytTests: XCTestCase {
    func testAddBookSuccessfully() {
        // ...
    }
}
```

```swift
import Testing
struct MySimpleLibrarytTests {
    @Test func addBookSuccessfully() {
        // ...
    }
}
```

= 期待値の確認

```swift
// XCTest
func testAddBookSuccessfully() {
    library.addBook(book)
    XCTAssertEqual(library.count, 1)
    XCTAssertNotNil(library.findBook(byISBN: "1234"))
}
```

```swift
// Swift Testing
@Test func addBookSuccessfully() {
    library.addBook(book)
    #expect(library.count == 1)
    #expect(library.findBook(byISBN: "1234") != nil)
}
```

== Xcode上の表示

`#expect` マクロはテスト失敗時の結果をきれいに表示する

#image("images/overview_expectation_failed.png", height: 80%)

== コメント

`#expect` にコメントを書くと、テスト失敗時に表示してくれる

```swift
// 空の本棚に1冊追加したので、本の数は1冊になるはず
#expect(library.count == 1)
```

#rect(image("images/expectation_failed_comment.png", width: 80%))

= テストスイート

```swift
struct MySimpleLibrarytTests {
    @Test func addBookSuccessfully() {
        // ...
    }
}
```

- テスト関数を含む型が、自動的にテストスイートになる
- 後述するトレイトを使う場合は `@Suite` 属性を指定する

== Swiftの機能の活用

```swift
final class MySimpleLibrarytTests {
    init() async throws {
        // ...
    }

    deinit {
        // ...
    }
}
```

- 専用の `setUp` の代わりに、通常の `init` が使える
- `actor` や `@MainActor` なども使える

= トレイト

テスト関数やテストスイートの振る舞いを指定する

```swift
@Suite(.timeLimit(.minutes(1)))
struct MySimpleLibrarytTests {
    @Test func addBookSuccessfully() {
        // ...
    }
}
```

- テストスイートのタイムアウト時間を指定する例

== 用意されているトレイト

- `.enabled` / `.disabled`
- `.timeLimit`
- `.serialized`
- `.tags`
- `.bug`
- `.isRecursive`

= Swift Testingの機能

Swift Testingならではの機能

- エラーのテスト
- パラメトライズテスト
- テストの並列実行

今回は、パラメトライズテストについて紹介

= パラメトライズテスト

== テスト関数に引数を渡す

入力や期待値をテスト関数の外側から渡せる

```swift
@Test(arguments:[(
    input: ...,
    expected: ...
)])
func addBook(input: InputData, expected: ExpectedData) {
    library.addBook(input.book)
    #expect(library.count == expected.count)
}
```

== 複数のデータでテストする

同じテスト関数を入力を変えて何度も実行できる

```swift
@Test(arguments:[
    (input: ..., expected: ...),
    (input: ..., expected: ...),
    (input: ..., expected: ...)
])
func addBook(input: InputData, expected: ExpectedData) {
    library.addBook(input.book)
    #expect(library.count == expected.count)
}
```

== Xcode上の表示

#grid(
  columns: 2,
  gutter: 1em,
  [#rect(image("images/running-tests-and-interpreting-results-parameterized-input@2x.png"))],
  [
    Xcodeのテストナビゲータで、パラメータごとに分かれて表示される

    - それぞれのテスト結果がわかる
    - 特定パラメータだけ実行できる
  ],
)

= まとめ

- Swift Testingの構成要素
  - テスト関数、期待値の確認、テストスイート、トレイト
- Swift Testingならではの機能
  - エラーのテスト、パラメトライズテスト、並列実行
