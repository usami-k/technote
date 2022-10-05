---
theme: apple-basic
canvasWidth: 720
highlighter: shiki
layout: intro
---

# Meet Swift Regex
## WWDC22セッション要約

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

- 来週6/27（月）にも、YUMEMI.swift #15でSwift Regexの話をします。

---

# Meet Swift Regex

- Swift 5.7で、正規表現を扱う `Regex` 型が追加される。
- 注意：セッション中のコードはビルドできないものがいくつかある。

---

# Scenario: Financial investigation

以下のような文字列データ（金融取引の記録）を処理したい。

```text
KIND      DATE          INSTITUTION                AMOUNT
----------------------------------------------------------------
CREDIT    03/01/2022    Payroll from employer      $200.23
CREDIT    03/03/2022    Suspect A                  $2,000,000.00
DEBIT     03/03/2022    Ted's Pet Rock Sanctuary   $2,000,000.00
DEBIT     03/05/2022    Doug's Dugout Dogs         $33.27
```

- 取引の種類、取引日、個人または機関名、金額
- 各フィールドは2つ以上のスペースまたはタブで区切られる。

---

# Processing collections

`split` で分割してはどうか。

```swift
let transaction = "DEBIT     03/05/2022    Doug's Dugout Dogs         $33.27"
let fragments = transaction.split(whereSeparator: \.isWhitespace)

// ["DEBIT", "03/05/2022", "Doug\'s", "Dugout", "Dogs", "$33.27"]
```

<mdi-arrow-down-thick class="text-2xl mx-50" />

- `["Doug\'s", "Dugout", "Dogs"]` は意図しない分割。
- 「2つ以上のスペースまたはタブ」で区切りたい。
-  そこで正規表現を使う。

---

# Processing strings

Regexリテラルが使える `split(by:)` が追加された。

```swift
let transaction = "DEBIT     03/05/2022    Doug's Dugout Dogs         $33.27"
let fragments = transaction.split(by: /\s{2,}|\t/)

// ["DEBIT", "03/05/2022", "Doug's Dugout Dogs", "$33.27"]
```

---

# struct Regex

Regexの生成方法は以下がある。

- Regex literals
- Runtime construction
- Regex builders

---

# struct Regex

```swift
// Regexリテラル
let digits = /\d+/

// 実行時に生成
let runtimeString = #"\d+"#             // 補足 : #"〜"# はSwiftの文字列リテラルの一種
let digits = try Regex(runtimeString)

// Regexビルダー
import RegexBuilder
let digits = OneOrMore(.digit)
```

---

# Swift Regex

以下の4つの強みがある。

- 簡明なリテラルと構造的なビルダーが使える。
- 正規表現の一部に既存のパーサーが使える。
- Unicodeを扱える。
- Predictable execution, prominent controls

---

# Create a Regex builder

```swift
import RegexBuilder
import Foundation

let fieldSeparator = /\s{2,}|\t/
let transactionMatcher = Regex {
  /CREDIT|DEBIT/
  fieldSeparator
  One(.date(.numeric, locale: Locale(identifier: "en_US"), timeZone: .gmt))
  fieldSeparator
  OneOrMore {
    NegativeLookahead { fieldSeparator }
    CharacterClass.any
  }
  fieldSeparator
  One(.localizedCurrency(code: "USD").locale(Locale(identifier: "en_US")))
}
```

---

# Capture

```swift
let transactionMatcher = Regex {
  Capture { /CREDIT|DEBIT/ }
  fieldSeparator
  Capture { One(.date(.numeric, locale: Locale(identifier: "en_US"), timeZone: .gmt)) }
  fieldSeparator
  Capture {
    OneOrMore {
      NegativeLookahead { fieldSeparator }
      CharacterClass.any
    }
  }
  fieldSeparator
  Capture { One(.localizedCurrency(code: "USD").locale(Locale(identifier: "en_US"))) }
}
```

---

# Capture

Captureした部分は、次のように取り出せる。

```swift
let transaction = "DEBIT     03/05/2022    Doug's Dugout Dogs         $33.27"
let match = transaction.wholeMatch(of: transactionMatcher) {
  let (kind, date, institution, amount) = match.output
  // ...
}
```

---

# Plot twist

金額の単位に応じて、日付部分のパース処理を変えたい。

```text
DEBIT     03/05/2022    Doug's Dugout Dogs         $33.27
DEBIT     06/03/2022    Oxford Comma Supply Ltd.   £57.33
```

- 金額が `$` の場合は `month/day/year` とみなす。
- 金額が `£` の場合は `day/month/year` とみなす。

---

# Plot twist

Foundationの `Date` パース時のstrategy機能を活用する。

```swift
func pickStrategy(_ currency: Substring) -> Date.ParseStrategy {
  switch currency {
  case "$":
    return .date(.numeric, locale: Locale(identifier: "en_US"), timeZone: .gmt)
  case "£":
    return .date(.numeric, locale: Locale(identifier: "en_GB"), timeZone: .gmt)
  default: fatalError("We found another one!")
  }
}
```

---

# Plot twist

```swift
let regex = #/
  (?<date>     \d{2} / \d{2} / \d{4})
  (?<middle>   \P{currencySymbol}+)
  (?<currency> \p{currencySymbol})
/#

ledger.replace(regex) { match -> String in
  let date = try! Date(String(match.date), strategy: pickStrategy(match.currency))
  let newDate = date.formatted(.iso8601.year().month().day())
  return newDate + match.middle + match.currency
}
```

---

# Unicode

```swift
switch ("🧟‍♀️💖🧠", "The Brain Cafe\u{301}") {
case (/.\N{SPARKLING HEART}./, /.*café/.ignoresCase()):
  print("Oh no! 🧟‍♀️💖🧠, but 🧠💖☕️!")
default:
  print("No conflicts found")
}
```

---

# TryCapture

TryCaptureでCaptureしたデータを変換できる。

```swift
let fieldSeparator = /\s{2,}|\t/
let field = OneOrMore {
  NegativeLookahead { fieldSeparator }
  CharacterClass.any
}
let transactionMatcher = Regex {
  Capture { /CREDIT|DEBIT/ }
  fieldSeparator
  TryCapture(field) { timestamp ~= $0 ? $0 : nil }
  fieldSeparator
  TryCapture(field) { details ~= $0 ? $0 : nil }
  fieldSeparator
  // ...
}
```

---

# Local

上述の正規表現は、セパレータの処理に無駄がある。
例えば、8つの空白を見つけた場合、次のようになる（グローバルバックトラッキング）。

- 8つの空白の残りが正規表現にマッチするか調べる。
- マッチしなければ、次に7つの空白の残りがマッチするか調べる。
- マッチしなければ、次に6つの空白の残りがマッチするか調べる。

これを避けるため、 `Local` を使うことができる。

```swift
let fieldSeparator = Local { /\s{2,}|\t/ }
```

---

# 次に見るセッション

より詳しくは「Swift Regex: Beyond the basics」のセッションを見よ。

