# PosTrail

## 🐴サイトテーマ：　外乗の思い出を投稿できるSNS
### 🌿そもそも「外乗（がいじょう）」とは？
山、森、川、海など**自然の中を乗馬しながら散策**できる野外アクティビティのことです。

「乗馬」と聞くと乗馬を習っていない方には関係ないように思えますが、多くの外乗施設では馬に全く乗ったことがない方でも外乗ができます。<br>
<p>
  <img width="51%" alt="外乗写真" src="https://user-images.githubusercontent.com/98644622/170825764-98df9107-0a9b-4fd5-8d0c-ae822b8a8cc2.jpg">
  <img width="48%" alt="外乗写真" src="https://user-images.githubusercontent.com/98644622/170825837-6c179693-7157-4558-b186-600dce23f09c.jpg">
</p>

### 🌿外乗の魅力
想像以上に背が高い馬の上から見る風景は格別です。
そんな馬上で経験する大自然の中での外乗は解放感に溢れていて、心からリラックスする事が出来ます。

外乗施設ごとに全く違う雰囲気を楽しめるのも大きな特徴です。

森林が近い外乗施設 → 普段なら近寄りもしないような神秘的な森の中を馬に乗りながら散策
海が近い外乗施設 　→ 海沿いをドライブするかのように馬に乗り潮風を浴びながら散歩

他にも乗馬を習っている方であればスキルに応じて森の中をくねくね駆け回ったり、草原や海沿いを爆走したりと、他では絶対に経験出来ないことを叶えてくれるのも外乗の大きな魅力の一つです。

## 🐴テーマを選んだ理由
#### きっかけ
前職が乗馬業界だったため、お客様からは「外乗に行くにはもっと乗馬スキルを上げないと…」といった意見をよく耳にしていました。

スキル関係なく外乗へ行けるのにも関わらず上記の意見が多い原因は、
実際に外乗に行ってきた方たちの生の声がとても少なく情報がほとんど無いからではないかと考えました。

以前、自分自身も行こうとしていた外乗施設の情報が少なく、楽しめるのかとても不安に思った経験があります。

こんな時に気になっている施設へ実際に行った方たちの声がたくさんあれば
外乗へ行く一歩を踏み出しやすくなるのではないかと考えたため、このサイトのテーマとして選びました。

#### 期待すること
外乗をよく知らなかった方たちが外乗を認知するきっかけになったり、
外乗をしてみたいけど迷っている方たちの後押しができることを期待します。

そうすることで外乗への敷居が下がり、外乗施設を利用する方が増えれば乗馬業界の盛り上がりにも貢献できるのではないかと感じています。

### 🌿ターゲットユーザー
- 外乗に行った人・行きたい人
- 自然の中で癒やされたい人
- 馬に乗ってみたい人
- 乗馬が気になっているけど習うほどでも無いと考えている人
- 旅行先でアクティブなことがしてみたい人

### 🌿主な利用シーン
- 楽しい外乗を経験したので、他の人にもその施設をオススメ・共有したい時
- 外乗に行きたいけれどその施設は初めてだからと迷っている時
- 他の方がどんな外乗をしているのか知りたい時
- 外乗がどんなものなのか知りたい時


# 🐴サイトURL
https://postrail.net

### 🌿機能一覧
- ログイン機能
- ゲストユーザー機能
- 管理者機能
- フォロー機能
- 投稿機能
- いいね機能
- コメント機能
- 通知機能
- 検索機能
- タグ機能

### 🌿非機能一覧
- haml
- sass
- active-hash
- bullet
- Rspec
- factory_bot_rails
- rubocop-airbnb
- GitHub Actions

## 🐴できること
一般的な投稿機能を持ったサイトです。
「クラブ名」には行った外乗施設名を入れます。(空欄可)
<p>
<img width="48%" alt="サイトイメージ4" src="https://user-images.githubusercontent.com/98644622/170831922-6c2651ec-67fc-4a3e-ac4b-61f7b67b462d.png">
<img width="44.3%" alt="サイトイメージ5" src="https://user-images.githubusercontent.com/98644622/170831770-d39bdeb2-6b49-4cba-8972-a7f670275013.png">
</p>

#### 検索機能を充実させています
「都道府県」「外乗施設」「タグ」で検索できます。
<p>
  <img width="45%" alt="サイトイメージ1" src="https://user-images.githubusercontent.com/98644622/170830274-5e9fcd7e-7c50-4fcf-b90c-e7fd7ac7f2a2.png">
  <img width="33.3%" alt="サイトイメージ2" src="https://user-images.githubusercontent.com/98644622/170830267-0bc2bf21-f8ce-480e-a919-3b2c2578e39d.png">
</p>

右上の虫眼鏡アイコンではフリーワード検索も可能です

  <img width="60%" alt="サイトイメージ3" src="https://user-images.githubusercontent.com/98644622/170830706-01683c13-629a-4c93-89b6-40aa2307d67d.png">

### 🌿工夫した点
- ユーザビリティを意識（例：タグは全角空白・半角空白で登録が可能）
- 外乗の普及に重きをおいた（アバウトページに外乗の魅力を書いた）
- コメント機能・いいね機能・フォロー機能・タグ検索機能は非同期通信化
- テスト仕様書を開発と並行してある程度書き進めることでテスト項目の漏れを最小限にした

### 🌿大変だった点
- 設計書作成：　チーム開発時の設計書を参考に作成
- EC２構築・デプロイ・HTTPS化の際に発生したエラー：
  何をしているのか分からないままコマンドを実行していたため、エラーの発生原因が全く理解できなかった。
  インフラ周りを復習することで何をしているコマンドなのかが少し理解できた。
  HTTPS化時には必要な記述を１文抜かしてしまったためにエラーが発生した。おかげでnginxのconfigファイルで何をしているのか理解が少しだけ進んだ。
- デザイン面・css：　色使いに悩んだが、sassの変数でメインカラーを決めることで統一感を出した

### 🌿完成までの工数
後日記入予定

## 🐴設計書
### 🌿ER図
<img width="95%" alt="ER図" src="https://user-images.githubusercontent.com/98644622/170824118-d0ef316b-6300-4dad-b952-9cf77d3f5ebf.png">

### 🌿フローチャート
ユーザー側

<img width="95%" alt="フローチャート" src="https://user-images.githubusercontent.com/98644622/170832517-cb8487ac-6d39-4fa0-b712-724934957e9a.png">

＊admin側、追加予定です

## 🐴開発環境
- OS：Linux(CentOS)　Amazon Linux release 2 (Karoo)
- 言語：HTML,CSS,JavaScript,Ruby(2.6.3p62),SQL
- フレームワーク：Ruby on Rails(6.1.6)
- JSライブラリ：jQuery
- IDE：Cloud9
-
どういうサイトか・何ができる・アピールポイント
画像も載せる
環境→バージョンも
機能一覧・非機能一覧（何でテスト？）

## 🐴使用素材(商用可)
|使用用途             |サイト名       |アドレス                                |
|-------------------|---------------------|------------------------------|
|アイコン              |Font Awesome         | https://fontawesome.com/
|ロゴ + No Image作成  |FLD FreeLogoDesign   | https://www.freelogodesign.org/
虫眼鏡アイコン          |IFN 1048 FREE ICONS  | https://illustration-free.net/
ユーザーアイコン（馬）     |ICOOOON MONO         | https://icooon-mono.com/
ユーザーアイコン(動物)   |vectorShelf          | https://vectorshelf.com/
素敵な写真集          |Unsplash             | https://unsplash.com/
人物のイラスト(about)   |ちょうどいいイラスト       | https://tyoudoii-illust.com/
