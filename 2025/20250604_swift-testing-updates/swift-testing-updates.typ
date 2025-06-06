#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: utils.display-current-heading(level: 1),
  config-info(
    title: [Swift Testingのアップデート],
    author: [宇佐見公輔],
    date: [2025-06-04 / 関西モバイルアプリ研究会A \#8],
    institution: [株式会社ゆめみ],
    logo: [#image("images/Profile_NFT.jpeg", height: 35%)],
  ),
)
#set text(font: ("0xProto", "IBM Plex Sans JP"), size: 24pt)
#show raw: set text(font: ("0xProto", "IBM Plex Sans JP"), size: 24pt)
#show raw.where(block: true): set text(font: ("0xProto", "IBM Plex Sans JP"), size: 20pt)
#show raw.where(block: true): set block(fill: rgb("#f3ede6"), inset: 1em)
#show link: it => underline(text(blue, it))
#show math.equation: set text(font: "STIX Two Math", size: 24pt)
#title-slide()

== 自己紹介

#grid(
  columns: 2,
  gutter: 1em,
  [
    === 宇佐見公輔（うさみこうすけ）
    - 株式会社ゆめみ：iOSテックリード

    === 近況
    - 技術書典18で#link("https://techbookfest.org/product/kNeYDqeMsjmejthYsZY4nR")[新刊]を出しました
    - 紙＋電子版を頒布（〜6/15（日））
  ],
  [
    #rect(image("images/BookTesting.png"))
  ],
)

== 宣伝

#grid(
  columns: 2,
  gutter: 1em,
  [
    === ゆめみ大技林
    - 今回で6冊目
    - 参加著者数もページ数も過去最大
    - 無償頒布

    === 僕が書いた記事
    - Rust Bevy によるクリエイティブコーディング
  ],
  [
    #rect(image("images/daigirin-25.png"))
  ],
)

= Swift Testing とは

== 概要

- Swiftでのユニットテストの新しいフレームワーク
- Swift 6.0 / Xcode 16.0 に統合（2024年9月）

=== 主な特徴

- マクロ機能を活用したテスト記述
- パラメトライズテスト
- テストの並列実行
- XCTestと併用可能

== テストコードの例

```swift
@Test func addBookSuccessfully() {
    let library = MySimpleLibrary()
    let book = MySimpleBook(isbn: "1234567890123")
    library.addBook(book)

    #expect(library.count == 1)
    #expect(library
              .findBook(byISBN: "1234567890123") != nil)
}
```

== アップデート

- Swift 6.1 / Xcode 16.3 で機能更新（2025年3月）
- Swift Testing本を出すとき、更新内容もいくつか反映

=== 今回の話

Swift 6.1 / Xcode 16.3 での更新内容をいくつか紹介します。

= UIテストのフレームワークが独立

== XCUIAutomation

- Swift Testingを使う場合も、UIテストはXCTestで書く

```swift
import XCTest
```

- UIテストの機能が、XCTestから分離された
- それがXCUIAutomationフレームワーク

```swift
import XCUIAutomation
```

- 余談："XC"という接頭語がやや冗長な気もする

= エラーのテストの改善

== エラーのテストの基本

- `#expect(throws:)` や `#require(throws:)` を使う
- これは従来も更新後も同じ

```swift
#expect(throws: MyError.self) {
    try myModel.doSomethingError()
}
```

== エラーのテストのカスタマイズ：従来（deprecated）

- エラーのチェックをカスタマイズしたい場合は、次の形のマクロを使って `throws` 引数のクロージャの中に判定を書いていた

```swift
#expect {
    try myModel.doSomethingError()
} throws: { error in
    let myError = try #require(error as? MyError)
    return myError.code == .error1
}
```

== エラーのテストのカスタマイズ：更新後

- `#expect(throws:)` や `#require(throws:)` がエラーを return するようになった
- シンプルなテストコードで書ける

```swift
let error = try #require(throws: MyError.self) {
    try myModel.doSomethingError()
}
#expect(error.code == .error1)
```

= パラメトライズテストの型推論

== パラメトライズテストの基本

```swift
@Test(arguments: [
    (
        book: MySimpleBook(isbn: "1234567890123"),
        searchISBN: "1234567890123"
    )
])
func addBook(book: MySimpleBook, searchISBN: String)
{
    // ...
}
```

== 型推論の制約：従来

- `arguments` の箇所はテスト関数からは型推論されないので、明示的な型指定が必要だった

```swift
@Test(arguments: [
    (
        book: Optional<MySimpleBook>.none
    )
])
func addBook(book: MySimpleBook?)
{
    // ...
}
```

== 型推論の拡張：更新後

- `arguments` の箇所も型推論されるようになった

```swift
@Test(arguments: [
    (
        book: nil
    )
])
func addBook(book: MySimpleBook?)
{
    // ...
}
```

= 非同期処理のテストの改善

== 非同期処理のテストの基本

- そもそもの基本は Swift Concurrency を使うこと
- それで難しい場合に `confirmation` を使う

```swift
await confirmation { confirm in
    library.eventHandler = { _ in
        confirm()
    }
    await library.addBook(book)
}
```

== カウントが追加

- `confirm` の回数をテストできるように
- `0` を指定すると「呼ばれないこと」をテストできる

```swift
await confirmation(expectedCount: 1) { confirm in
    library.eventHandler = { _ in
        confirm()
    }
    await library.addBook(book)
}
```

= Test Scopingトレイトの追加

== トレイトの基本

- `@Test` や `@Suite` に属性を付与するのがトレイト
- 用意されているトレイトのほか、カスタムトレイトも作れる

```swift
@Test(.timeLimit(.minutes(1)))
func addBookSuccessfully() {
    // テスト実行時間が1分を越えると、中断して不合格扱いになる
}
```

== Test Scopingトレイト

- カスタムトレイトのバリエーションが増えた
- テストの前後にカスタムコードを実行するトレイトが作れる

```swift
@Test(.mockAPICredentials)
func example() {
    // ここの実行前後に、mockAPICredentials トレイトで定義した
    // カスタムコードが実行される
}
```

== Test Scopingトレイトの実装

```swift
struct MockAPICredentialsTrait: TestTrait, TestScoping {
    func provideScope(for: ..., testCase: ...,
            performing function: ...) async throws {
        // ここに `function` を呼ぶカスタムコードを書く
    }
}
extension Trait where Self == MockAPICredentialsTrait {
    static var mockAPICredentials: Self {
        Self()
    }
}
```

== Test Scopingトレイトの使いみち

正直、使いみちがあまり分かっていません。

- `setUp` / `tearDown` の実現？
  - シンプルな `init` / `deinit` で足りる
  - それで足りないような複雑なことをしたい場合があれば有益か
- モックの挿入？
  - モックの値はテスト内容に応じて変えたい場合が多いので、トレイトだとやりづらい気がする

= まとめ

== 紹介した更新内容

Swift 6.1 / Xcode 16.3 で機能更新（2025年3月）

- UIテストのフレームワークが独立
- エラーのテストの改善
- パラメトライズテストの型推論
- 非同期処理のテストの改善
- Test Scopingトレイトの追加
