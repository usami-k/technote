#import "@preview/touying:0.6.1": *
#import themes.metropolis: *
#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  footer: utils.display-current-heading(level: 1),
  config-info(
    title: [Xcode ＋ AIアシスト],
    author: [宇佐見公輔],
    date: [2025-06-20 / YUMEMI.grow Mobile \#22],
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
    - ゆめみiOSテックリード

    === 近況
    - 7/5（土）大阪ライブ出演
    - 7/20（日）東京ライブ出演
    - ブレーミア結成40年
    - https://chor-vremya.com/
  ],
  [
    #rect(image("images/vremya2025.png"))
  ],
)

== 本の紹介

#grid(
  columns: 2,
  gutter: 1em,
  [
    === Swift Testing本
    - 技術書典18で#link("https://techbookfest.org/product/kNeYDqeMsjmejthYsZY4nR")[新刊]を出しました
    - 電子版を引き続き頒布中
  ],
  [
    #rect(image("images/BookTesting.png"))
  ],
)

== ゆめみの活動紹介

#grid(
  columns: 2,
  gutter: 1em,
  [
    === ゆめみ大技林
    - 技術書典18で無償頒布
    - 次回も準備中
    - 引き続き社外からも執筆者を募集
  ],
  [
    #rect(image("images/daigirin-25.png"))
  ],
)

= AI活用の考えかた

== AI活用の考えかた2つ

=== AIにコーディングをさせる
人間が開発の指示を出し、AIは指示に従ってコーディングをする。

- 要件などのドキュメントを与えて、AIが開発をする
- Claude Codeなどは、アプリ開発もできている

=== AIにアシスタントをさせる
人間がコーディングをして、AIはそれを補助する。

- IDEとチャットAIとの結合
- AIエージェントによる編集

== AIによるアプリ開発

AIにコーディングをさせるのが、現在の主流となってきている。

この場合、人間は次のようなことをやっていく。

- AIのための開発環境を整備する
- AIが読みやすいドキュメントを与える
- AIリーダブルな形式でUIデザインを与える
- コーディングガイドラインをルールセットとして与える

== AIによるアシスト

主流でなくなりつつあるが、現在の僕のスタンスはこっち。

自分が何をしたいか。

- 自分がコーディングをしたい
- 誰かにコーディングをさせたいわけじゃない

だから、AIはアシスタントとして使っていく。

今日はそのスタンスでの話。

=== 補足
AIにコーディングをさせるのが主流にはなっていくので、ウォッチはしておく。場合によってはスタンスを切り替える。

= Xcode 26

== Xcode 26

WWDC25で、XcodeのAIアシスト機能が発表された。

- 昨年と異なり、今年はベータ版で実際に動作する
- さまざまなモデルが利用できる
  - 例えばデフォルトのChatGPTからClaude Sonnetに変更可

=== 必要な環境
- macOS 26 beta
- Xcode 26 beta

今日はベータ版の具体的な話はしません。

== 補足：ベータ版の試しかた

=== ベータ版の利用条件
- Apple Developer Programに加入する必要がある

=== macOSベータ版のインストール
- APFSボリュームを追加（パーティション分け不要）
- そのボリュームにmacOSをインストール（インストーラを使う）
- そのボリュームで起動して、ベータ版にアップグレード

参考：#link("https://support.apple.com/ja-jp/118282")[複数のバージョンのmacOSをMacで使う - Apple サポート (日本)]

= GitHub Copilot for Xcode

== GitHub Copilot for Xcode

- GitHub公式のXcode拡張
- https://github.com/github/CopilotForXcode

=== 機能
- チャット
- エージェント
- コード補完

== 日本語での応答に対応

- 以前はチャットの応答が英語になることが多かった
- GitHubのIssueで要望を出した
  - Feature Request: Allow selecting Copilot Chat response language
  - https://github.com/github/CopilotForXcode/issues/271
- 0.36で改善
  - チャットの応答言語が設定できるようになった
  - `.github/copilot-instructions.md` も参照する

== 今後の展開

=== 現時点
- 現時点でXcodeと組み合わせて使えるAIアシストとしては、GitHub Copilotが使いやすい

=== 今後
- Xcode 26のAIアシスト機能に移行するかも
- GitHub Copilotも選択肢としてはある

= AIアシストの実際の利用

== モデルの選択で賢さが変わる

GitHub Copilot for Xcodeでは、使用するモデルを選べる。

この選択はきちんと注意を払っておく。

- 基本的に、Claude Sonnetが賢い
- GPT-4系は不正確であることが多い

== コード補完は使わない

入力中に自動でAIがコード補完してくれる機能がある。

しかし問題が多いので、AIの自動コード補完はオフにする。

- 期待通りのコードを補完してくれない
- 補完されたコードがビルドできない
- むしろIDEのコード補完の邪魔になる

（必要に応じてショートカットキーなどでコード補完を呼ぶ）

== チャットやエージェントを使う

コード補完ではなく、チャットやエージェントを中心に使う。

- 現在見ているコードに基づいた調べもの
- コードレビュー
- コーディングの相談相手
- コードの編集

== コードレビュー

AIにコードレビューをしてもらうのは有益。

- 有益なレビューもあれば、そうでないものもある
- 対応したいものだけ対応すればよい
- 自分では気づかなかった指摘がもらえることもある
- コードを見直すきっかけとして利用する

== コーディングの相談相手

AIは雑に相談できる。

- 「もうちょっといい感じのコードにならないか」とか
- 雑に振っても、何かしらの案は出してくれる
- それをきっかけに考えられる

ただし、応答内容はあまり真に受けすぎない。

- あまり信用はしすぎない
- もっともらしく言っているが全然おかしい内容であることも多い

== コードの編集

AIエージェントに既存コードを編集してもらう。

- いきなり編集させるのではなく、まず現状を調べてもらう
- どう編集するのがいいか、方針を考えさせる
- 良さそうなら、実際に編集してもらう

最終的には、AIに任せず自分でコーディングすることも多い。

あくまでAIはアシストなので、それでよいというスタンス。

== AIに任せたいケース

コードの編集を特にAIに任せたくなるのは、機械的な編集のとき。

- 数字を連番でふりたいとか
- 一定のルールで関数名や変数名を作りたいとか

人間がやるとケアレスミスやスペルミスなどやらかしそうな編集は、むしろAIに任せたほうがうまくいく。

得意・不得意を考えて、良いパートナーとしてやりたい。

== 類似のバグを探してもらう

何かのバグ修正をしたときに、似たようなバグが他にないか調べることは多い。そうしたこともAIに任せると良い。

- 類似の問題が疑われるところをピックアップしてくれる
- 最終的な判断は人間がやればよい

== テストコードを書かせる

AIにテストコードを書いてもらうのも良い。

- テストコードは機械的な作業であることが多い
- テストが網羅的かどうかの判断はAIの得意領域

うまくテストコードを書いてくれない場合は、ひとつくらい人間が見本でテストコードを書いてやる。

AIは、新しく生み出すよりも、類似のものを真似するほうが得意。

= まとめ

== まとめ

=== AI活用のスタンス
- AIにコーディングをさせる
- AIにアシスタントをさせる

=== XcodeのAIアシスト
- Xcode 26
- GitHub Copilot for Xcode

=== AIアシストの実際の利用
- コード補完ではなく、チャットやエージェントを中心に使う
- AIの得意領域を活かす
