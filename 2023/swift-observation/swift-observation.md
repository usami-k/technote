---
marp: true
headingDivider: 1
theme: gaia
style: |
    section { font-family: '游教科書体 横用'; font-weight: bold; }
    h1 { font-family: '游ゴシック体'; }
paginate: true
footer: SwiftのObservationフレームワークによる値の監視
---

# Swiftの<br>Observationフレームワークによる<br>値の監視
<!-- _class: lead -->

宇佐見公輔 / 株式会社ゆめみ
2023-12-13

# 自己紹介

* 宇佐見公輔（うさみこうすけ）
* 株式会社ゆめみ / iOSテックリード

![width:210](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/2377560/8886f190-c479-4195-bc8a-bc6c05634fb8.png) ![width:210](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/2641333/5384ddb9-7f57-4aa1-aef9-4a339b3ed16f.png) ![width:210](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/3622327/6aee6e0d-ecfc-4db3-9e5b-988981cfed9f.png) ![width:210](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/4841376/255e28df-c614-4bce-9b1c-4bfe9bb0b5f0.png) ![width:210](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/5278270/e9ca14f6-6826-47de-859c-181bc0cc43f7.png)

# Observationフレームワーク

* Swiftで値の変更を監視するためのフレームワーク
* データバインディングの実現
    * とくにSwiftUIでの利用を想定
* Swift 5.9で追加された
    * iOS 17など最新OSでのみ動作する
    * 将来のデファクトスタンダード

# Swiftにおける値の変更の監視

* KVO（Key-Value Observing）
    * Objective-Cからの機能
* ObservableObject
    * Combineフレームワークの機能
* @Observable
    * Observationフレームワークの機能

# @Observable

* Swift 5.9で追加されたマクロ機能で実現

```swift
@Observable
final class Model {
    var value: Int = 0
}
```

* クラスに `@Observable` をつけると、そのクラスが監視可能になる

# withObservationTracking

```swift
final class ViewController: UIViewController {
    private let model = Model()

    private func tracking() {
        withObservationTracking { [weak self] in
            guard let self else { return }
            print("value: \(model.value)")
        } onChange: {
            print("onChange")
        }
    }
}
```

# 変更の監視を開始する

```swift
        withObservationTracking { ...
            ...
            print("value: \(model.value)")
        } onChange: {
            ...
        }
```

* `withObservationTracking` のクロージャで監視対象が決まる
    * `model.value` を参照 → `model.value` の値が監視対象となる

# 変更が通知される

```swift
        withObservationTracking { ...
            ...
        } onChange: {
            print("onChange")
        }
```

* `model.value` の値が変更されると `onChange` クロージャが呼ばれる

# 動作の確認

* `tracking()` を呼び出すと `print("value: ...")` が呼ばれる

```
value: 0
```

* `model.value` の値を変更すると `print("onChange")` が呼ばれる

```
onChange
```

* なお、この通知は1回だけ来る

# 監視を継続する

```swift
    private func tracking() {
        withObservationTracking { ...
            ...
        } onChange: {
            Task { @MainActor [weak self] in
                guard let self else { return }
                tracking()
            }
        }
    }
```

* 再帰的に呼び出すことで、変更の監視を継続できる

# UIKitでの利用例

```swift
    private func tracking() {
        withObservationTracking { [weak self] in
            guard let self else { return }
            label.text = "value: \(model.value)"
        } onChange: {
            Task { @MainActor [weak self] in
                guard let self else { return }
                tracking()
            }
        }
    }
```

# SwiftUIの場合

```swift
struct MyView: View {
    var model = Model()
    
    var body: some View {
        Text(model.value)
    }
}
```

* これだけで継続的に値の変更を監視できる
    * `body` 内で参照されているプロパティが監視対象になる
    * `withObservationTracking` の記述は不要

# 不要な監視は発生しない

```swift
@Observable
final class Model {
    var value1: Int = 0
    var value2: Int = 0
}

struct MyView: View {
    var model = Model()
    
    var body: some View {
        Text(model.value1) // value2 の変更では再描画されない
    }
}
```

# コレクションの監視

```swift
struct LibraryView: View {
    @State private var books = [Book(), Book(), Book()]

    var body: some View {
        List(books) { book in 
            Text(book.title)
        }
    }
}
```

* `books` への要素の追加や削除を監視してViewを更新できる
* `book.title` の変更では、該当Viewだけが更新される

# Observableフレームワークの制約

* 構造体には `@Observable` をつけられない
    * 値型（構造体）では使えず、参照型（クラス）で使える
    * Swiftは構造体の値変更を監視するようには設計されてない
* バックポートには対応しない
    * 古いバージョンのSwiftUIを対応させるのが難しい

# おわりに

* Observationは既存の方法よりもシンプルで効率的
* SwiftUIとの相性が良い
* 古いOSで使えないのでまだ採用できないが、将来のスタンダード
