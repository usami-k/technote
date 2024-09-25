#import "@preview/touying:0.5.2": *
#import themes.metropolis: *
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: utils.display-current-heading(level: 1),
  config-info(
    title: [XCTestからSwift Testingへ],
    author: [宇佐見公輔],
    date: [2024-09-25],
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
- 株式会社ゆめみ
  - iOSテックリード
- iOSDC Japan 2024
  - パンフレット記事 / ポスターセッション

= Swift Testingとは

== Swift Testingとは

- Swift用の単体テストフレームワーク
  - 従来のXCTestに比べて、Swiftの機能をより活用
- Swift公式のGitHubリポジトリで公開されている
  - https://github.com/swiftlang/swift-testing
- Xcode 16に統合された
  - XcodeのUIと連携する

== XCTestとSwift Testing

- XCTest
  - 従来からの単体テストフレームワーク
- Objective-C時代から存在、Swiftにも適合
  - https://github.com/swiftlang/swift-corelibs-xctest
- XCTestとSwift Testingは同じプロジェクトで混在可能
  - そのため、少しずつ移行していくことが可能

= Swift Testingの基本

== テスト関数定義：XCTest

```swift
import XCTest

class FoodTruckTests: XCTestCase {
    func testEngineWorks() {
        // ...
    }
}
```

- `XCTestCase` のサブクラス内で定義する必要
- メソッド名を `test` 始まりで命名する必要

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
- `@Test` 属性をつければメソッド名は自由

== テストの実装

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

== Optional値のUnwrap

```swift
// XCTest
func testEngineWorks() throws {
    let part = try XCTUnwrap(engine.parts.first)
}
```

```swift
// Swift Testing
@Test func engineWorks() throws {
    let part = try #require(engine.parts.first)
}
```

== テスト実行時のsetup/teardown

```swift
// XCTest
class FoodTruckTests: XCTestCase {
    override func setUp() async throws {
        // ...
    }
}
```

```swift
// Swift Testing
final class FoodTruckTests {
    init() async throws {
        // ...
    }
}
```

== 変換ツール

- XCTestのコードをSwift Testingに変換するツール
  - https://github.com/giginet/swift-testing-revolutionary

= Swift Testingの機能

== パラメータを変えてテスト

```swift
enum Food {
  case burger, iceCream, burrito, noodleBowl, kebab
}

@Test(arguments: [
    Food.burger, .iceCream, .burrito, .noodleBowl, .kebab
])
func foodAvailable(_ food: Food) async throws {
    let foodTruck = FoodTruck(selling: food)
    #expect(await foodTruck.cook(food))
}
```

== 複数のパラメータ

```swift
@Test(arguments: zip(Food.allCases, 1 ... 100))
func makeLargeOrder(of food: Food, count: Int) async throws {
  let foodTruck = FoodTruck(selling: food)
  #expect(await foodTruck.cook(food, quantity: count))
}
```

== テスト実行制御

```swift
@Test(.enabled(if: FoodTruck.sells(.arepas)))
func arepasAreTasty() {
    // ...
}
```

```swift
@Test(.timeLimit(.seconds(30))
func serveLargeOrder() {
    // ...
}
```

== アノテーション

```swift
@Test func grillWorks() async {
    withKnownIssue("Grill is out of fuel") {
        try FoodTruck.shared.grill.start()
    }
}
```

= 非同期処理のテスト

== 非同期処理のテスト：XCTest

```swift
func testTruckEvents() async {
    let soldFood = expectation(description: "…")
    FoodTruck.shared.eventHandler = { event in
        soldFood.fulfill()
    }
    await Customer().buy(.soup)
    await fulfillment(of: [soldFood])
}
```

`expectation` を使う。`fulfill()` が呼ばれたら成功。

== 非同期処理のテスト：Swift Testing

```swift
@Test func truckEvents() async {
    await confirmation("…") { soldFood in
        FoodTruck.shared.eventHandler = { event in
            soldFood()
        }
        await Customer().buy(.soup)
    }
}
```

`confirmation` を使う。confirmed が呼ばれたら成功。

== 注意点

- XCTestの `expectation` では `await fulfillment()` で完了待ちをしていた。
- Swift Testingの `confirmation` は完了待ちをしない。ブロックを抜けるまでに confirmed メソッドが呼ばれないと失敗扱い。

この点では、不便になっているようにも見えるが・・・

== 解決策(1)

Swift Concurrencyの `withCheckedContinuation` を使う。

```swift
@Test func truckEvents() async {
  await confirmation("…") { soldFood in
    await withCheckedContinuation { continuation in
      FoodTruck.shared.eventHandler = { event in
        soldFood()
        continuation.resume()
      }
      await Customer().buy(.soup)
    }
  }
}
```

== 解決策(2)

pointfreeco/swift-concurrency-extras の `megaYield` を使う。

```swift
@Test func truckEvents() async {
  await confirmation("…") { soldFood in
    FoodTruck.shared.eventHandler = { event in
      soldFood()
    }
    await Customer().buy(.soup)
    await Task.megaYield()
  }
}
```

= まとめ

== XCTestからSwift Testingへ

- XCTestから段階的に移行できる
- 機械的に移行できる部分も多い
- パラメータテストが便利
- 非同期処理のテストは少し変わっているので注意
