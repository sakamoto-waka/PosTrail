# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

Admin.create!(email: ENV['ADMIN_EMAIL'], password: ENV['ADMIN_PASSWORD'])


users = User.create!(
  [
    {email: 'saddle@test.com', name: 'さっとん', password: 'password', introduction: "乗馬歴3年ですがまだまだ初心者です…。\r楽しく乗馬しています！", account_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")},
    {email: 'whip@test.com', name: 'ウイ', password: 'password', introduction: "初めての乗馬が外乗でした。\r今では馬の魅力にどっぷりハマってます", account_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.png")},
    {email: 'hakusha@test.com', name: 'はく', password: 'password', introduction: "外乗で駈歩を夢見て特訓中", account_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")},
    {email: 'bridle@test.com', name: 'ぶー', password: 'password', introduction: "森での外乗が特に好きです", account_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user4.png"), filename:"sample-user4.jpg")},
    {email: 'shoe@test.com', name: 'しょう', password: 'password', introduction: "旅行先で馬に乗るのが好きなんです", account_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user5.png"), filename:"sample-user5.jpg")},
    {email: 'girth@test.com', name: 'ガース', password: 'password', introduction: "うまだいすき", account_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user6.jpg"), filename:"sample-user6.jpg")},
    {email: 'sttirup@test.com', name: "寿天楽布", password: 'password', introduction: "外乗最高", account_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user7.jpg"), filename:"sample-user7.jpg")},
    {email: 'bit@test.com', name: 'モーイ', password: 'password', account_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user8.jpg"), filename:"sample-user8.jpg")}
  ]
)

Post.create!(
  [
    {prefecture_id: 14, trail_place: 'トレッキングファーム', trail_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"), body: "マジ最高の外乗でした！\r今回は海沿いを襲歩に近いスピードでかっ飛ばし爽快でした。また行きたいな〜。", user_id: users[0].id },
    {prefecture_id: 8, trail_place: 'ホースパーク', trail_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg"), body: 'すごくガッチリした馬で外乗しました！サラブレッドとは違った新鮮な体験ができた。', user_id: users[1].id },
    {prefecture_id: 1, trail_place: 'ホーストレッキング', trail_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"), body: '川沿いを外乗しました。北海道ならではの景色でとってもいやされました〜。', user_id: users[2].id },
    {prefecture_id: 1, trail_place: 'らんどグラス', trail_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg"), body: "超絶ワイルドでした！馬ってこんなところも平気なんだって発見もありました。\rもちろんレベルに合わせて外乗してくれると思いますがワイルドな外乗をお求めな方は是非！", user_id: users[3].id },
    {prefecture_id: 47, trail_place: '波馬', trail_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post5.jpg"), filename:"sample-post5.jpg"), body: "今回は丘の上にあるジェラートを食べるコースを選択しました。\r馬たちはとっても穏やかで、もちろんジェラートも美味しかったですよ^^", user_id: users[4].id },
    {prefecture_id: 47, trail_place: '波馬', trail_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post6.jpg"), filename:"sample-post6.jpg"), body: '海沿いを走ってきました！石垣の潮風最高でした。変わった馬具を使ってるところも要チェックです！', user_id: users[5].id },
    {prefecture_id: 44, trail_place: 'ウェスタンライディング', trail_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post7.jpg"), filename:"sample-post7.jpg"), body: '外乗コースがたまらなくいいです！日本では珍しく草原のような所を走れます！', user_id: users[0].id },
    {prefecture_id: 44, trail_place: 'エル・グランデ', trail_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post8.jpg"), filename:"sample-post8.jpg"), body: '初めて乗りましたが馬も穏やかで、スタッフの皆さんもとても親切でした。最高の思い出が作れました！', user_id: users[7].id },
    {prefecture_id: 14, trail_place: 'トレッキングファーム', trail_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post9.jpg"), filename:"sample-post9.jpg"), body: '海沿いをポコポコ散歩しました〜。波の音と相まって最高にリラックスできました。', user_id: users[4].id },
    {prefecture_id: 12, trail_place: 'ステーブルス', trail_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post10.jpg"), filename:"sample-post10.jpg"), body: '結構な距離、海沿いを走らせてもらいました！初めてこんなに長距離走りました！！', user_id: users[6].id }
  ]
)

Tag.create!(
  [
    {name: "夏"},
    {name: "秋"},
    {name: "紅葉"},
    {name: "初心者"},
    {name: "楽しい"},
    {name: "爽快"},
    {name: "思い出"},
    {name: "また行きたい"},
    {name: "もっと外乗したい"}
  ]
)

# それぞれのpostに一つずつtagを付与、最終的に複数のタグを持つように
post_tag_array = [  [1, 2], [1, 3], [1, 7], [2, 1], [2, 9], [3, 1],
                    [3, 4], [3, 5], [4, 2], [4, 7], [5, 2], [5, 3],
                    [6, 8], [7, 1],[7, 5], [9, 8], [9, 9],
                    [10, 3], [10, 6]
                 ]

post_tag_array.each do |post_id, tag_id|
  PostTag.create!(
    post_id: post_id,
    tag_id: tag_id
  )
end

Question.create!(
  [
    {user_id: users[0].id, title: '夏の格好について', riding_experience: '2年', content: '夏はどんな格好で乗ればいいでしょうか？', is_answered: true, answer: "夏は暑いですが半袖半ズボンは避けたほうがよいでしょう。\r安全面的にも、虫も多いため長袖長ズボンをおすすめします。\r半袖のポロシャツなどの下に夏用の長袖インナーを着ている方が多いです。ズボンはひんやりジーンズなど長ズボンで暑くなければ良ければ何でも大丈夫です。"},
    {user_id: users[1].id, title: '馬が走ってくれない', riding_experience: '3年', content: '馬がなかなか走ってくれません。どうするべきでしょうか？', category: 1, is_answered: true, answer: "走るときだけ合図を出すのはNGです。\r常歩中に少しなにか合図を出してみましょう。\r少しスピードを上げてもらう、少しスピードを緩めてもらう、右側によって歩いてもらうなど、難しいことではなく簡単なものにしましょう。\rここでいちばん大事なのが、言うことを聞いてもらうことです。もし合図を無視するのであれば必ず言うことを聞くまでアクションを起こしましょう。\r馬が乗り手を意識すれば走る時の合図も聞いてくれやすくなります。"},
    {user_id: users[3].id, title: '持ち物について', riding_experience: '1年', content: '初めて外乗に行きますが必要な持ち物などはあるのでしょうか？', is_answered: true, answer: "施設によっても違いますが、ヘルメットなど外乗に必要なものは貸し出してくれる施設がほとんどです。\r稀に貸し出しが無い施設もありますので問い合わせてみたほうが良いです。あとは万が一汚れたときのことを考えて着替えがあると安心です。"},
    {user_id: users[5].id, title: '冬の格好について', riding_experience: '1年', content: '冬はどんな格好で乗れば良いでしょうか？'},
  ]
)