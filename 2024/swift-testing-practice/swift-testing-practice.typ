#import "@preview/touying:0.5.2": *
#import themes.metropolis: *
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: utils.display-current-heading(level: 1),
  config-info(
    title: [Swift Testingを活用する],
    author: [宇佐見公輔],
    date: [2024-10-18],
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
- 50歳になりました
  - 節目なので、健康診断でMRIとかCTスキャンとか

== 最近のアウトプット

- Swift Testing
  - #set text(gray, size: 24pt); 関モバ \#5
- 3次元回転とクォータニオン / Accelerate
  - #set text(gray, size: 24pt); iOSDCポスターセッション / Mobile Act OSAKA 13
- iOSアプリ開発の知識
  - #set text(gray, size: 24pt); iOSDCパンフレット記事
- Apple Vision ProのUI / フォーカス操作
  - #set text(gray, size: 24pt); 関モバ \#4 / YUMEMI.grow Mobile \#15

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
@Suite
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
}
```

- 専用の `setUp` の代わりに、通常の `init` が使える
- `actor` や `@MainActor` なども使える

= トレイト

テスト関数やテストスイートの振る舞いを指定する

- テスト関数のタイムアウト時間を指定する例

```swift
@Test(.timeLimit(.seconds(30))
func serveLargeOrder() {
    // ...
}
```

== 用意されているトレイト

- `.enabled` / `.disabled`
- `.timeLimit`
- `.serialized`
- `.tags`
- `.bug`
- `.isRecursive`

= Swift Testingの機能

Swift Testingならではの機能をいくつか紹介

- エラーのテスト
- パラメトライズテスト
- テストの並列実行

= エラーのテスト

```swift
var order = PizzaToppings(bases: [.calzone, .deepCrust])
#expect(throws: PizzaToppings.Error.outOfRange) {
    try order.add(topping: .mozarella,
                  toPizzasIn: -1..<0)
}
```

- 自前で `do` 〜 `catch` するテスト実装が不要に
- throwされなければテスト失敗になってくれる
  - 自前でテスト実装したときにやりがちなミス

== エラーのテストのカスタマイズ

```swift
#expect {
    FoodTruck.shared.engine.batteryLevel = 0
    try FoodTruck.shared.engine.start()
} throws: { error in
    return error == EngineFailureError.batteryDied
        || error == EngineFailureError.stillCharging
}
```

- 単純な等価判定では都合が悪い場合は `errorMatcher` を実装
  - エラーが `Equatable` でない場合など

= パラメトライズテスト

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

== Xcode上の表示

#grid(
  columns: 2,
  [
    #image("images/running-tests-and-interpreting-results-parameterized-input@2x.png")
  ],
  [
    Xcodeのテストナビゲータで、パラメータごとに分かれて表示される

    - それぞれのテスト結果がわかる
    - 特定パラメータだけで実行できる
  ],
)

= テストの並列実行

- デフォルトで、テストは並列実行される
- テスト関数
  - パラメトライズテストの場合、各テストが並列実行
- テストスイート
  - 各テスト関数やサブスイートが並列実行

== テストの直列実行

グローバルな状態を操作するテストは並列実行だと困る

```swift
@Suite(.serialized)
struct FoodTruckTests {
    @Test func refill() { ... }
    @Test func startEngine() async throws { ... }
}
```

- `.serialized` トレイトで並列でなく直列実行にできる

== 複数テストスイートの直列実行

```swift
@Suite(.serialized) struct MultipleTests {}

extension MultipleTests {
    struct FoodTruckTests { ... }
}
extension MultipleTests {
    struct OtherTests { ... }
}
```

- サブスイートも直列実行にできる
- なお、`.serialized` トレイトはサブスイートにも適用される

= まとめ

- Swift Testingの構成要素
  - テスト関数、期待値の確認、テストスイート、トレイト
- Swift Testingの機能
  - エラーのテスト
  - パラメトライズテスト
  - テストの並列実行
