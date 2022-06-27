# 🐎PosTrail


## サイトテーマ：　外乗(Trail)の思い出を投稿(Post)できるSNS
#### そもそも「外乗（がいじょう）」とは？
山、森、川、海など**自然の中を乗馬しながら散策**できる野外アクティビティのことです。

「乗馬」と聞くと乗馬を習っていない方には関係ないように思えますが、多くの外乗施設では馬に全く乗ったことがない方でも外乗ができます。<br>
<p>
  <img width="51%" alt="外乗写真" src="https://user-images.githubusercontent.com/98644622/170825764-98df9107-0a9b-4fd5-8d0c-ae822b8a8cc2.jpg">
  <img width="48%" alt="外乗写真" src="https://user-images.githubusercontent.com/98644622/170825837-6c179693-7157-4558-b186-600dce23f09c.jpg">
</p>

#### 外乗の魅力
想像以上に背が高い馬の上から見る風景は格別です。
そんな馬上で経験する大自然の中での外乗は解放感に溢れていて、心からリラックスする事が出来ます。

また、外乗施設ごとに全く違う雰囲気を楽しめるのも大きな特徴です。

森林が近い外乗施設:　普段なら近寄りもしないような神秘的な森の中を馬に乗りながら散策<br>
海が近い外乗施設:　海沿いをドライブするかのように馬に乗り潮風を浴びながら散策

他にも乗馬を習っている方であればスキルに応じて森の中をくねくね駆け回ったり、草原や海沿いを爆走したりと、他では絶対に経験出来ないことを叶えてくれるのも外乗の大きな魅力の一つです。

![投稿デモ](https://user-images.githubusercontent.com/98644622/170912005-441e4ce7-2f44-460e-9bc0-3481b0e380b6.gif)

## テーマ選定理由
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

#### ターゲットユーザー
- 外乗に行った人・行きたい人
- 自然の中で癒やされたい人
- 馬に乗ってみたい人
- 乗馬が気になっているけど習うほどでも無いと考えている人
- 旅行先でアクティブなことがしてみたい人

#### 主な利用シーン
- 楽しい外乗を経験したので、他の人にもその施設をオススメ・共有したい時
- 外乗に行きたいけれどその施設は初めてだからと迷っている時
- 他の方がどんな外乗をしているのか知りたい時
- 外乗がどんなものなのか知りたい時

# サイトURL
https://postrail.net

#### 機能一覧
- ユーザー認証機能(devise)
- ゲストユーザー機能
- 管理者機能
- 質問機能
- フォロー機能
- DM機能
- 投稿機能
- 都道府県(active-hash)
- いいね機能
- コメント機能
- 通知機能
- 検索機能
- タグ機能

#### 非機能一覧
- haml
- sass
- bullet
- Rspec
- factory_bot_rails
- rubocop-airbnb
- GitHub Actions

## できること
投稿機能を持ったサイトです。  

#### 検索機能を充実させています

右上の虫眼鏡アイコンでフリーワード検索が可能です

<img width="100%" alt="検索" src="https://user-images.githubusercontent.com/98644622/170912056-8c713d6f-34b0-4ccc-8e8f-82aac82f8a7d.png">

他にも「都道府県」「外乗施設」「タグ」で検索できます。
<p>
  <img width="56.9%" alt="サイトイメージ1" src="https://user-images.githubusercontent.com/98644622/170830274-5e9fcd7e-7c50-4fcf-b90c-e7fd7ac7f2a2.png">
  <img width="42.1%" alt="サイトイメージ2" src="https://user-images.githubusercontent.com/98644622/170830267-0bc2bf21-f8ce-480e-a919-3b2c2578e39d.png">
</p>

#### 管理者機能を取り入れています

本番運用を意識し、投稿・コメント・タグを削除できる権限を与えました。
また、ユーザーの削除後も投稿が残るように論理削除を実装しました。<br>
**管理者側**では「名前+(削除済みユーザー)」へと自動で切り替わります。

<img width="100%" alt="admin退会処理" src="https://user-images.githubusercontent.com/98644622/174517393-9dde5b8c-c6db-4e4f-a8ed-2b353f793900.png">

**ユーザー側**では「退会済みユーザー」として表示されます。

<img width="100%" alt="退会済みユーザー" src="https://user-images.githubusercontent.com/98644622/174517636-eb1b4810-da23-4433-b309-4996fe59ea3c.png">

#### 工夫した点
- 外乗の普及に重きをおいた（アバウトページに外乗の魅力、質問機能で外乗へのハードルを下げる）
- ユーザビリティを意識（例：タグは全角空白でも登録が可能）
- モデルにメソッドを切り出し、リファクタリングに努めた
- DM機能・コメント機能・いいね機能・フォロー機能・タグ検索機能は非同期通信化
- テスト仕様書を開発と並行してある程度書き進めることでテスト項目の漏れが無い様に努めた

#### 大変だった点
- **設計書作成**<br>
以前はあまり考えずに実装し、うまくいかなければやり直しというスタイルで学習を行えていたが、PF制作では初期段階でもやり直しは絶対にしないという気持ちで望んだため時間がかかった<br>
しかし製作中はどうしても初期段階では気が付けなかった部分があり手戻りが発生したので、経験を積んでより精巧な設計書を作成できるようになりたいと感じた

- **EC２構築・デプロイ・HTTPS化への理解と、発生したエラー**  
エラー① MySQLでDBを作成する際に小文字のみで作成してしまい、アプリケーションとDBを繋げられずエラー  
エラー② HTTPS化時に必要な記述を１文書き忘れたためエラー  
エラー③ ドメイン取得後もipアドレスでサイトへアクセスしようとしていたため404エラー  
特に②と③は同じタイミングで発生したためシンプルなエラーだったが解決に時間がかかった  
しかしエラーが発生したおかげで何のための記述なのかを意識するようになったため、インフラ周りの理解が少し進んだ

- **DM機能の通知設定**  
あまり記事が多くなく、その記事通り実装してもうまく動作しなかったため解決に時間がかかった。<br>しかしデバッグして解決、を自力で行えたためとても勉強になった

- **S3バケット**  
バケットポリシーの許可不足によるエラーで画像が中々取得できず、解決に3日ほどかかった。特に最後はローカルと本番環境でエラー内容が違ったため解決に時間がかかった

# 設計書
### ER図
<img width="100%" alt="pf-er図" src="https://user-images.githubusercontent.com/98644622/173808809-55d2c20d-f2f0-435c-ba81-09d04ac80e4b.png">

### フローチャート
- ユーザー側

<img width="100%" alt="フローチャート" src="https://user-images.githubusercontent.com/98644622/170832517-cb8487ac-6d39-4fa0-b712-724934957e9a.png">

- 管理者側

<img width="100%" alt="adminフローチャート" src="https://user-images.githubusercontent.com/98644622/174517155-287358c3-e66a-404a-85bd-2cd9dcb7f0b3.png">

### 開発環境
- OS： Linux(CentOS)　Amazon Linux release 2 (Karoo)
- 言語： HTML,CSS,JavaScript,Ruby(2.6.3),SQL
- フレームワーク： Ruby on Rails(6.1.6)
- JSライブラリ： jQuery
- IDE： Cloud9
- DB: sqlite3

### アプリケーション相関図
<img width="100%" alt="アプリケーショ相関図" src="https://user-images.githubusercontent.com/98644622/175300900-b847ec6d-45b0-46eb-ad23-a5c56fc2539f.png">

### インフラ設計書
https://docs.google.com/spreadsheets/d/18lojfy8jh-F9g1E4aIktUnQUyRkEagTdxXOXW7HeNwg/edit?usp=sharing

<img width="100%" alt="インフラ設計図" src="https://user-images.githubusercontent.com/98644622/175302889-84f5282f-6bae-4ada-a517-38cfecb74e71.png">

## 使用素材(商用可)
|使用用途             |サイト名       |アドレス                                  |
|-------------------|---------------------|--------------------------------|
|アイコン              |Font Awesome         | https://fontawesome.com
|ロゴ + No Image作成  　|FLD FreeLogoDesign   | https://www.freelogodesign.org
|虫眼鏡アイコン        　　|IFN 1048 FREE ICONS  | https://illustration-free.net
|ユーザーアイコン（馬）    　|ICOOOON MONO         | https://icooon-mono.com
|ユーザーアイコン(動物)  　|vectorShelf          | https://vectorshelf.com
|素敵な写真集        　　　|Unsplash             | https://unsplash.com
|人物のイラスト(about)  |ちょうどいいイラスト      　 | https://tyoudoii-illust.com

#### フロントで使用した雛形等
|使用用途             |サイト名       |アドレス                                   |
|-------------------|---------------------|---------------------------------|
|ボタン               |See-SS               | https://see-ss.com            
|ボタン               |JAJAAAN!             | https://jajaaan.co.jp
|見出しやボタンなど     　|サルワカ               | https://saruwakakun.com
|検索バー            　|Coco-Factory         | https://coco-factory.jp/
|アコーディオンメニュー　　　　　　　|PENGIN BLOG　　　　　　　　　　　　　　　　　　　　| https://pengi-n.co.jp/
