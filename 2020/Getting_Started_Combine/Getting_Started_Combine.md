slide-dividers: #
theme: Courier, 3
slidenumbers: true
slidecount: true

# Combine をはじめよう
## USAMI Kosuke

# 自己紹介

- 宇佐見 公輔
- フェンリル株式会社（大阪本社）iOS エンジニア
- Mobile Act 主催
- iOSDC 原稿準備中

# Combine とは

# Combine とは

- Reactive Programming のフレームワーク
    - RxSwift や ReactiveSwift と同類
- 非同期処理を柔軟に記述できる
- モデルと UI のバインディングを記述できる

# 昨年発表されて話題になった

- Combine は昨年の WWDC19 で発表された
- 話題にはなったものの、iOS 13 でのみ使用可能
    - → 実際の開発に適用しにくかった
- しかし、1年たった現在、状況は異なる

# iOS アプリの開発事情

- 理想的には最新 OS のみをサポートしたい
- しかし実際は、少し前の OS のサポートを要望される
    - 最新 OS とその1つ前の OS までのサポートが現実路線
- iOS 14 リリース後は iOS 13 〜 14 対応は現実的

# Combine の現状

- 昨年時点で、既にある程度成熟したフレームワークといえる
    - Reactive Programming は既に新しいものではない
    - 今年の追加機能はほとんどない

# 他のフレームワークとの比較

- 既に Reactive Programming フレームワークはある
    - RxSwift : ReactiveX 系
    - ReactiveSwift : Swift の良さを活かしている
- Combine の利点
    - サードパーティ製でなく標準である

# なぜ、いま Combine をはじめるのか

- タイミングがちょうど良い
    - iOS 13 以降を対象とすることが現実的に可能になってきた
    - ある程度成熟したフレームワークであり安心して使える
- 標準フレームワークなのでサードパーティ依存しない

# UIKit / SwiftUI

- Combine はどちらとも組み合わせられる汎用的なもの
- 今は UIKit の組み合わせが現実的
- SwiftUI は iOS 13 対応が必要な状況では機能不足気味
    - iOS 14 では大きく改善している

# Combine を学ぼう

# Combine を学ぼう

- WWDC19 のセッション
    - 今なら日本語字幕もある
- 様々な人が記事や書籍を書いている
    - 昨年登場以降で注目度が高いことが分かる
- 他のフレームワークとの用語の違いには注意

# なんだかちょっと難しそう・・・？

- いきなり全部やろうとしても難しいかもしれない
- できるだけ簡単なサンプルコードを考えてみましょう

# 例 : NotificationCenter

```swift
let cancellable =
    NotificationCenter.default
    .publisher(for: NSControl.textDidChangeNotification,
               object: textField)
    .sink(receiveValue: {
        /* イベント処理 */
    })
```

# 例 : URLSession

```swift
let cancellable =
    URLSession.shared
    .dataTaskPublisher(for: request)
    .sink(receiveValue: {
        /* イベント処理 */
    })
```

# 共通する形がある

```swift
let cancellable =
    何らかのオブジェクト
    .publisher(for: ...)
    .sink(receiveValue: {
        /* イベント処理 */
    })
```

# 基本形

- `Publisher` がイベントを送出する
- `sink` でイベントを処理する
    - `sink` は `Subscriber` を生成する

# Combine を使う意味

- 以下のような非同期処理をすべて Combine で書ける
    - Target / Action
    - Notification Center
    - URL Session
    - Key-Value Observing
    - Callback

# Combine の3つの基本要素

- Publisher : イベントを送出する
- Operator
- Subscriber : イベントを処理する

# Operator を使えるのが強み

- 複数のイベントを監視して処理する、などが簡単になる
    - `Zip`
    - `CombineLatest`
    - など

# 補足 : UIControl の対応

- `UIButton` などの `Publisher` が標準では用意されていない
    - これは標準で欲しかったところだが・・・
- カスタム `Publisher` を実装して対応する
- 参考 : [【Swift】Custom Publisherを作成してCombineフレームワークの動きを学ぶ](https://qiita.com/shiz/items/58abf44b77d9da2042f1) - @shiz さんの Qiita 記事

# 補足 : UIControl の対応

カスタム `Publisher` を実装すれば以下のようなことができる

```swift
let cancellable =
    button
    .publisher(for: ...)
    .sink(receiveValue: {
        /* イベント処理 */
    })
```

# まとめ

- Combine はいま始めるのがちょうど良い
- ぱっと見では難しそうだが基本は簡単

