slide-dividers: #
theme: Courier, 3
slidenumbers: true
slidecount: true
slidenumber-style: Courier, text-scale(1.5)
header: YuGothic Bold
text: YuKyokasho Yoko Medium
code: SF Mono Regular

# AsyncSequence
## ってなに？
### 宇佐見 公輔
### 2021-06-30

# 宇佐見 公輔（@usamik26）

- フェンリル株式会社 iOS エンジニア / テックリード
- 技術同人誌
    - Combineをはじめよう
    - CombineとUIKitによるiOSアプリ開発
- 記事執筆予定
    - iOSDC Japan 2021 : Combine Operator ガイド

# Swift Concurrency

- 非同期処理が実装しやすくなる（iOS 15 以降）
    - `async` / `await`
    - Structured Concurrency
    - Actor
- 今回は `async` / `await` の話

# async / await を使わない場合

```swift
func fetchThumbnail(completion: (UIImage?, Error?) -> Void) {
    let task = URLSession.shared.dataTask(with: request) { ...
        if let error = error {
            completion(nil, error)
        } else {
            // ... data / response の処理 ...
            completion(thumbnail, nil)
        }
    }
    task.resume()
}
```

# async / await を使う場合

```swift
func fetchThumbnail() async throws -> UIImage {
    let (data, response)
        = try await URLSession.shared.data(for: request)
    // ... data / response の処理 ...
    return thumbnail
}
```

- `await` の箇所でサスペンド、処理が終わったら復帰

# URLSession のメソッド

```swift
// async / await 非対応版
func dataTask(with request: URLRequest, 
              completionHandler:
                (Data?, URLResponse?, Error?) -> Void)
                                    -> URLSessionDataTask

// async / await 対応版
func data(for request: URLRequest) async throws
                                    -> (Data, URLResponse)
```

# AsyncSequence とは

- `Sequence` の `async` / `await` 対応版
- どういうこと？
- まず `Sequence` のおさらい

# Sequence

- `Sequence` プロトコルに準拠した型では・・・
- `for-in` 構文が使える
- 値は同期的に渡される

```swift
for quake in quakes {
    // ... quake の処理 ...
}
```

# AsyncSequence

- `AsyncSequence` プロトコルに準拠した型では・・・
- `for-await-in` 構文が使える
- 値は非同期的に渡される

```swift
for await quake in quakes {
    // ... quake の処理 ...
}
```

# Sequence をイテレータで見る

```swift
for quake in quakes {
    // ... quake の処理 ...
}

var iterator = quakes.makeIterator()
while let quake = iterator.next() {
    // ... quake の処理 ...
}
```

# AsyncSequence をイテレータで見る

```swift
for await quake in quakes {
    // ... quake の処理 ...
}

var iterator = quakes.makeAsyncIterator()
while let quake = await iterator.next() {
    // ... quake の処理 ...
}
```

# AsyncSequence オペレータ

```swift
let strings = quakes.map { (quake) -> String in
    // ... quake を String に変換 ...
}

for await string in strings {
    // ... string の処理 ...
}
```

# AsyncSequence の並列処理

```swift
let task1 = async {
    for await quake in quakes {
        // ... quake の処理 ...
    }
}
let task2 = async {
    for await string in strings {
        // ... string の処理 ...
    }
}
// task1.cancel()
```

# Combine との比較

- `AsyncSequence` は Combine と扱う問題領域が似ている
- `AsyncSequence`
    - iOS 15 以降、言語組み込み構文、シンプルで分かりやすい
- Combine
    - iOS 13 以降、オペレータが豊富、複数ストリームのマージ

# 今後はどうなる？

- 共存？
    - C# では `async` / `await` と Rx が混在して使われている
- 融合？
    - 仕様策定中の `AsyncStream` がお互いを融合するかも？
- 現時点ではどちらともいえない

# 参考情報

- WWDC21 セッション : Meet AsyncSequence
- API リファレンス : `AsyncSequence` プロトコル
