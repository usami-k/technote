#import "@preview/touying:0.5.3": *
#import themes.metropolis: *
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: utils.display-current-heading(level: 1),
  config-info(
    title: [モバイルアプリのアクセシビリティを改めて勉強している話],
    author: [宇佐見公輔],
    date: [2024-12-11],
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
  columns: 2,
  gutter: 1em,
  [
    === 最近の出来事

    月刊I/O 2024年12月号に、組版システムTypstの記事を書きました

    - 最近、スライド作成やポスター作成もTypstでやっている
  ],
  [
    #rect(image("images/io-2024-12.jpg", height: 70%))
  ],
)

= ゆめみとアクセシビリティ

== ゆめみのタスクフォース

#align(
  center,
  [
    #image("images/yumemi-taskforce.jpg", height: 60%)
    https://note.com/ryokatsuse/n/n0b0b5deca657
  ],
)

== 読書会

#grid(
  columns: 2,
  gutter: 1em,
  [
    #rect(image("images/978-4-297-14603-0.jpg", height: 80%))
  ],
  [
    - 既に読書会や勉強会をいくつも実施
    - 「モバイルアプリアクセシビリティ入門」読書会が開催中
      - 今日、第3回が終わりました

    https://gihyo.jp/book/2024/978-4-297-14602-3
  ],
)

= アクセシビリティとは

== 言葉の意味

- 「アクセシビリティ」＝「利用可能な状況の幅広さ」
  - そもそもの「まず利用自体は可能である」というラインをどれだけ幅広く達成できているか
- 似た言葉に「ユーザビリティ」がある
  - こちらはいわゆる「使いやすさ」


== ユーザビリティとアクセシビリティ

#align(
  center,
  [
    #rect(image("images/usability-accessibility.png", height: 100%))
  ],
)

= モバイルアプリ開発とアクセシビリティ

== 実は自然に取り組んでいる

モバイルアプリ開発のなかで、自然にやっていること

- 標準コンポーネントの利用
- 複数デバイス対応
  - デバイスサイズの違い
  - タブレットなどの対応

== それ以上の取り組みもある

対応する意識や工数は必要だけど、実際やることも多い

- フォントサイズ可変対応
- ダークモード対応
- 音声読み上げ対応（VoiceOver / Talkback）

== モバイルアプリ開発者はアクセシビリティに詳しい？

じゃあ、モバイルアプリ開発者はそんなに勉強しなくていい？

→必ずしもそうとはいえない

- ひとつひとつの対応や機能をとってみれば、知識として知っていたり、実際に取り組んだ経験があったりする
- でも、アクセシビリティ全体の知識としては、意外と把握できていなくて抜けていたりする

== そこで改めて勉強していく

ここまでの話は、つまりは僕自身のこと。

- それぞれのアクセシビリティ対応は、実際に開発プロジェクトでの経験がある
- しかし、アクセシビリティ全体の知識としては抜けがある

そのため、前述の「モバイルアプリアクセシビリティ入門」を読むなど勉強していく。

= アクセシビリティは誰のため？

== 障害者や高齢者だけのためではない

- 障害者や高齢者によっては、利用するものがアクセシブルであるかどうかは、生活に直結する重要な問題

一方、そうでない人はどうか？

- 誰にでも「利用できない」という状況は起こる
- 加齢による衰え、アクシデントによる障害

== ここでちょっとした違和感

ただ、その考え方だと、うっかりすると・・・

- 自分にもいつかはアクセシビリティが重要になる
- でも、今の自分には重要ではない

という発想になってしまいそう。

なんだか他人事みたい。正直、僕にもそんな気持ちがあった。

== 医学モデルと社会モデル

そんな発想になるのは、障害はそれぞれの人の身体の問題だという考え方があるから。

- 医学モデル
  - 障害は人の身体側にある
- 社会モデル
  - 障害は社会の側にある
  - 社会や環境が対応できていないがゆえに障害が生じている

アクセシビリティを考えるうえでは、社会モデルで考える。

== モバイルアプリは社会の一部

もはや、モバイルアプリは社会の一部だ。

- モバイルアプリのユーザーは非常に多い
- 利用時間も長く、生活の一部になっている
- 繰り返し継続的に利用する

そのため、モバイルアプリは社会モデルにおいて、障害を発生させてしまう側にある。

= さまざまなアクセシビリティ

== 障害にもいろいろある

フォントサイズ、ダークモード、音声読み上げなどは、主に次の障害を想定している。

- ロービジョン（弱視）
- 色覚特性（色弱）
- 全盲

実は考えるべき障害はほかにもある。

== 上肢障害

腕・手・指が動かしにくい。

- タッチ操作が困難
- キーボード、マウス、スイッチなどでの操作を考慮する

== 聴覚障害

音が聞こえにくい。

- 通知音を聞くのが困難
- 画面の点滅や、触覚フィードバックで通知する

== 認知・学習障害

精神障害のなかでも、認知・学習障害は課題になりやすい。

- 情報を一時的に記憶する必要がある操作が難しい
- 画面上の情報を把握するのに時間がかかる
- 注意が散漫になる

各種のアクセシビリティ機能によるサポートが必要になる。

= 勉強のすすめ

== 勉強のすすめ

- アクセシビリティに関する本などを読むのがおすすめ
- また、自分でアクセシビリティ機能を常用してみる
- 個人的に、iOSの次の機能は常用している
  - 「カラー以外で区別」
  - 「オン／オフラベル」
  - 「ボタンの形の表示」