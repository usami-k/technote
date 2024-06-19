---
marp: true
headingDivider: 1
theme: gaia
style: |
    section { font-family: 'YuKyokasho Yoko'; font-weight: bold; }
    h1 { font-family: 'YuGothic'; }
    code { font-family: '0xProto'; }
    pre { background-color: black; }
paginate: true
footer: SwiftのAccelerateフレームワーク
---

# SwiftのAccelerateフレームワーク
<!-- _class: lead -->

宇佐見公輔（usami-k）
2024-05-31
Mobile Act OSAKA 13

# 自己紹介

- iOSアプリ開発エンジニア
- Mobile Act OSAKAの発起人
- 2013〜2021：フェンリル
- 2022〜現在：ゆめみ

![bg right:40% contain](https://pbs.twimg.com/media/GOLNTjwagAEpffp?format=jpg&name=large)

# 近況(1)

おもしろ同人誌バザール、技書博、技術書典に、技術同人誌を個人で出展しました

![width:170](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/2377560/8886f190-c479-4195-bc8a-bc6c05634fb8.png) ![width:170](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/2641333/5384ddb9-7f57-4aa1-aef9-4a339b3ed16f.png) ![width:170](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/3622327/6aee6e0d-ecfc-4db3-9e5b-988981cfed9f.png) ![width:170](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/4841376/255e28df-c614-4bce-9b1c-4bfe9bb0b5f0.png) ![width:170](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/5278270/e9ca14f6-6826-47de-859c-181bc0cc43f7.png) ![width:170](https://booth.pximg.net/c4cb0469-30f5-431d-acac-22d09c61cdb5/i/5668997/a9e084c1-05b0-4d98-8b2f-cbc2660dc807.png)

# 近況(2)

iOSDC Japan 2024パンフレット原稿採択されました（執筆中）

トークも応募する予定

![bg right:60% contain](https://fortee.jp/iosdc-japan-2024/proposal/og-image/c40d5199-526b-4bf9-91d7-2a0bc609b305.png)

# Accelerateフレームワークとは
<!-- _class: lead invert -->

# Accelerateフレームワークとは

- Appleが提供する数値計算ライブラリ群
- CPUのベクタ演算機能を活用
- iOS 4 / macOS 10.3 / tvOS 9 / watchOS 2 / visionOS 1

https://developer.apple.com/jp/accelerate/
https://developer.apple.com/documentation/accelerate/

# Accelerate vs Metal

- CPUのベクタ演算機能を活用：Accelerate
- GPUのベクタ演算機能を活用：Metal
- 両者は機能がが重なっている
- 実のところ、GPUが使えるならMetalのほうが効率が良い

https://developer.apple.com/jp/metal/
https://developer.apple.com/documentation/metal/

# Accelerateフレームワークの機能

- 機械学習：BNNS
- 画像処理：vImage
- デジタル信号処理：vDSP
- ベクトルに対する関数演算：vForce
- 線形代数：BLAS / LAPACK / Sparse Solvers

# BNNS
<!-- _class: lead invert -->

# BNNS

- BNNS＝Basic Neural Network Subroutines
- CPU上でニューラルネットワークの演算を高速に実行

BNNSよりも以下を使うほうが良い。

- Core ML
    - 内部でMetalやAccelerateを使っている
- Metal Performance Shaders Graph（MPS Graph）
    - GPU上でニューラルネットワークの演算を高速に実行

# vImage
<!-- _class: lead invert -->

# vImage

- CPU上で画像処理を高速に実行

vImageよりも以下を使うほうが良い。

- Core Image
    - 内部でMetalやAccelerateを使っている
- Metal
    - GPU上で画像処理を高速に実行

# vDSP
<!-- _class: lead invert -->

# vDSP

- DSP＝Digital Signal Processing
- 主に音声処理で使われる
- 高速フーリエ変換（FFT）
- デジタルフィルタリング
- その他、ベクトルに対する算術演算（加減乗除）

# 音声関連

- 再生・録音
    - Media Playerフレームワーク
    - AVFoundationフレームワーク
- 音声処理
    - Core Audio：デバイス入出力
    - vDSP：信号処理

# vDSPの事例

同僚が「iPhoneで楽器チューナを作ってみる」という記事を書いています。

「ゆめみ大技林 '22」は無償で頒布中です。

「'23」「'23 (2)」「'24」も頒布中。

![bg right contain](https://techbookfest.org/api/image/18Ywinj33TbLHjnmwDU3fe.png)

# vForce
<!-- _class: lead invert -->

# vForce

ベクトルに対する関数演算

```swift
let num = 1_000_000
let input = (0..<num).map { Float($0) }
```

```swift
// vForceを使っていない計算
let output = input.map { sqrt($0) }
```

```swift
// vForceを使った計算
let output = vForce.sqrt(input)
```

# vForceの書きかた2種類

`UnsafePointer`を使う書きかた（C言語由来）

```swift
var num = Int32(1_000_000)
var input = (0..<num).map { Float($0) }
var output = [Float](repeating: 0, count: input.count)
vvsqrtf(&output, &input, &num)
```

`UnsafePointer`を使わない書きかた

```swift
let output = vForce.sqrt(input)
```

# BLAS / LAPACK / Sparse Solvers
<!-- _class: lead invert -->

# BLAS / LAPACK

- BLAS＝Basic Linear Algebra Subroutines
    - 線形代数の数値演算ライブラリのAPI仕様
- LAPACK＝Linear Algebra PACKage
    - BLASの上位パッケージ
- BLASやLAPACKのAPIを実装したライブラリが多く存在している
    - Accelerateもそういった実装のひとつ

# Sparse Solvers

- 線形代数の数値演算で、疎行列の扱いに特化したライブラリ
    - 疎行列＝多くの成分が0の行列
- 行列のサイズが大きくても効率的に計算できる
- 扱う行列が疎行列かどうかは開発者が判断して、ライブラリを選択する

![bg right:40% contain](https://docs-assets.developer.apple.com/published/67710ae997/f7696e9f-9788-432e-bb39-4e6ff6302f2a.png)

# Accelerateのまとめ・活用箇所
<!-- _class: lead invert -->

# Accelerateのまとめ

- ベクトルや行列に対する数値演算に適している
    - デジタル信号処理：vDSP
    - ベクトルに対する関数演算：vForce
    - 線形代数：BLAS / LAPACK / Sparse Solvers
- 機械学習や画像処理ができるが最適解ではない
    - それらはCore ML、Core Image、Metalが良い

# Accelerateの活用箇所

Apple製のライブラリで以下のものにAccelerateが活用されている

- Apple Archive（ファイル圧縮）
- Spatial（軽量な3D数学ライブラリ）
- Quadrature（定積分の近似計算）

