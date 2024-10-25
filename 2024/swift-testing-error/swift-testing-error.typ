#import "@preview/touying:0.5.2": *
#import themes.metropolis: *
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: utils.display-current-heading(level: 1),
  config-info(
    title: [Swift Testingによる\ エラーのテスト],
    author: [宇佐見公輔],
    date: [2024-10-24],
    institution: [株式会社ゆめみ],
    logo: [#image("images/Profile_NFT.jpeg", height: 35%)],
  ),
)
#set text(font: "Explex35", size: 26pt)
#show math.equation: set text(font: "STIX Two Math")
#show raw: set text(font: "0xProto")
#show link: it => underline(text(blue, it))
#title-slide()

== 自己紹介

- 宇佐見公輔
  - 株式会社ゆめみ iOSテックリード

- 最近のアウトプット
  - Swift Testingを活用する（Mobile Act OSAKA 14）
  - XCTestからSwift Testingへ（関モバA \#5）
  - 3次元回転とクォータニオン（iOSDC Japan 2024）

== Swift Testingの技術同人誌

- Swift Testingの技術同人誌を制作中
- 11月2日（土）からの技術書典17に出展予定
  - （今回はオンラインのみの出展）

= Swift Testingとは

Swift用の単体テストフレームワーク

- Swift公式のGitHubリポジトリで公開されている
  - https://github.com/swiftlang/swift-testing
- Xcode 16に統合された
- XCTestとの関係
  - 従来のXCTestに比べて、Swiftの機能をより活用
  - XCTestと同じプロジェクトで混在可能

== Swift Testingの構成要素

- テスト関数
  - `@Test` 属性
- 期待値の確認
  - `#expect` マクロ
- テストスイート
  - `@Suite` 属性
- トレイト
  - `TestTrait` / `SuiteTrait`

= テスト関数

== テスト関数定義：XCTest

```swift
import XCTest

class FoodTruckTests: XCTestCase {
    func testEngineWorks() {
        // ...
    }
}
```

- `XCTestCase` のサブクラス内で定義する必要がある
- メソッド名を `test` 始まりで命名する必要がある

== テスト関数定義：Swift Testing

```swift
import Testing

struct FoodTruckTests {
    @Test
    func engineWorks() {
        // ...
    }
}
```

- テスト関数はどこで定義してもよい
- メソッドに `@Test` 属性をつければテスト関数になる

= 期待値の確認

```swift
// XCTest
func testEngineWorks() throws {
    XCTAssertNotNil(engine.parts.first)
    XCTAssertGreaterThan(engine.batteryLevel, 0)
    XCTAssertTrue(engine.isRunning)
}
```

```swift
// Swift Testing
@Test func engineWorks() throws {
    try #require(engine.parts.first != nil)
    #expect(engine.batteryLevel > 0)
    #expect(engine.isRunning)
}
```

== Xcode上の表示

`#expect` マクロはテスト失敗時の結果をきれいに表示する

#image("images/running-tests-and-interpreting-results-debug-expanded-gap-results@2x.png", height: 80%)

= テストスイート

```swift
struct FoodTruckTests {
    @Test
    func engineWorks() {
        // ...
    }
}
```

- テスト関数を含む型が、自動的にテストスイートになる
- 後述するトレイトを使う場合は `@Suite` 属性を指定する

== Swiftの機能の活用

```swift
final class FoodTruckTests {
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
struct FoodTruckTests {
    @Test
    func engineWorks() {
        // ...
    }
}
```

- テストスイートのタイムアウト時間を指定する例
- ちなみに `TimeLimitTrait.Duration` は `.minutes` 指定のみ

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

今回は、エラーのテストについて紹介

= エラーのテスト

== エラーのテスト：XCTest

- 素朴に `do` 〜 `catch` でテストを書いた場合

```swift
func testExample() throws {
    let myModel = MyModel()
    do {
        try myModel.doSomething()
        XCTFail("Expect to throw error")
    } catch {
        XCTAssertEqual(error as? MyError, .someError)
    }
}
```

== エラーのテスト：XCTest

- `XCTAssertThrowsError` を使うとより安全に書ける

```swift
func testExample2() throws {
    let myModel = MyModel()
    XCTAssertThrowsError(
        try myModel.doSomething()
    ) { error in
        XCTAssertEqual(error as? MyError, .someError)
    }
}
```

== エラーのテスト：Swift Testing

- `#expect` マクロで書ける

```swift
@Test func example() throws {
    let myModel = MyModel()
    #expect(throws: MyError.someError) {
        try myModel.doSomething()
    }
}
```

== エラーのテスト：Swift Testing

- 特定の型のエラーであるかを確認

```swift
#expect(throws: MyError.self) {
    ...
}
```

- 特定のエラーインスタンスと一致するかを確認
  - この場合、エラー型が `Equatable` であることが必要
```swift
#expect(throws: MyError.someError) {
    ...
}
```

== エラーのテストのカスタマイズ

- エラー判定をカスタマイズしたい場合
  - エラーが `Equatable` でない場合などに有益

```swift
@Test func example2() throws {
    let myModel = MyModel()
    #expect {
        try myModel.doSomething()
    } throws: { error in
        return error as? MyError == .someError
    }
}
```

== エラーが発生しないことのテスト

- 単にコードをテスト関数の中に書けばよい

```swift
@Test func example3() throws {
    let myModel = MyModel()
    try myModel.doSomething2()
}
```

- `#expect(throws: Never.self)` という書き方も可能
  - エラーが `throw` されても処理を続行したい場合

= まとめ

- Swift Testingの構成要素
  - テスト関数、期待値の確認、テストスイート、トレイト
- Swift Testingの機能として、エラーのテストを紹介
  - 型やインスタンスの一致を確認
  - 確認処理のカスタマイズ
