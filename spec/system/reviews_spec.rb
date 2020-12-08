require 'rails_helper'

RSpec.describe '新規投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    
  end
  context '新規投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      #ログイン
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      
      # 新規投稿ページへのリンクを発見
      expect(page).to have_content('Write')
      
      # 投稿ページに移動する
      visit new_review_path

      # フォームに情報を入力する      
      # 画像の投稿情報を定義し、入力
      image_path = Rails.root.join('public/images/index_contents.jpg')
      attach_file('review[image]', image_path, make_visible: true)
      
      # タイトルの投稿情報を定義し、入力
      title = "ランチェスター戦略"
      fill_in 'Title', with: title
      
      # カテゴリーを選択
      select '経済/ビジネス', from: 'Category'

      # limit_idを選択
      select '3日間', from: 'Time Limit'

      # textの投稿情報を定義して入力
      text = "ランチェスター法則は戦闘の勝敗を示す軍事理論です。
      軍隊の強さ・力を示す戦闘力は武器と兵力数で決まるというものです。
      武器は敵と味方の武器の性能や腕前を比率化した武器効率で捉えます。
      敵の2倍の性能の武器で戦えば味方の武器効率は2です。
      敵が味方の2倍の腕前なら味方の武器効率は0.5です。
      兵力数は兵士や戦車や戦闘機の数です。
      物量です。
      武器効率と兵力数を掛け合わせたものが軍隊の戦闘力です。
      
      法則は二つあります。
      それは戦い方によるものです。"
      fill_in 'review-text', with: text
      # 送信すると投稿のカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Review.count }.by(1)

      # 投稿完了ページに遷移することを確認する
      expect(current_path).to eq reviews_path
      # 投稿したレビュー内容が存在することを確認する（画像）
      expect(page).to have_selector ("img")
      # 投稿したレビュー内容が存在することを確認する（タイトル）
      expect(page).to have_content(title)
      # 投稿したレビュー内容が存在することを確認する（投稿者）
      expect(page).to have_content(@user.name)
    end
  end
  context '新規投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移
      visit root_path
      # 新規投稿リンクがない

      expect(page).to have_no_content("Write")
    end
    it "投稿内容に不備があると投稿できない" do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path

      # 新規投稿画面に遷移
      visit new_review_path

      # 全て空欄または未選択で入力
      fill_in 'Title', with: ""
      fill_in 'review-text', with: ""
      select 'select', from: 'Category'
      select 'select', from: 'Time Limit'

      # 送信しても投稿が保存されない
      expect{
        find('input[name="commit"]').click
      }.to change { Review.count }.by(0)

      expect(current_path).to eq "/reviews" 
    end
  end
end

RSpec.describe '投稿編集', type: :system do
  before do
    @review1 = FactoryBot.create(:review)
    @review2 = FactoryBot.create(:review)
    sleep 0.2
  end
  context '投稿編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した投稿の編集ができる' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @review1.user.email
      fill_in 'Password', with: @review1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿詳細ページに遷移
      visit review_path(@review1)
      #「編集」ボタンがあることを確認する
      expect(page).to have_link 'Edit', href: edit_review_path(@review1)
      # 編集ページへ遷移する
      visit edit_review_path(@review1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#book-title').value
      ).to eq @review1.title

      expect(
        find('#book-category').value
      ).to eq @review1.category_id.to_s  
      
      expect(
        find('#limit').value
      ).to eq @review1.limit_id.to_s
      
      expect(
        find('#review-text').value
      ).to eq @review1.text
      
      # 投稿内容を編集する
      image_path2 = Rails.root.join('public/images/sample.jpg')
      attach_file('review[image]', image_path2, make_visible: true)
      
      # タイトルの投稿情報を定義し、入力
      title2 = "嫌われる勇気"
      fill_in 'Title', with: title2
      
      # カテゴリーIDを選択
      select '自己啓発', from: 'Category'

      # limit_idを選択
      select '７日間', from: 'Time Limit'

      # textの投稿情報を定義して入力
      text2 = "職場では、上司の顔色をうかがったり、上司によく思われたいと考えたりして、気持ちを曲げて発言する人がいます。
      同僚などとの横のつながりでも、自分がどう思われるのかをいつも気にして、嫌われないようにする。
      なるべく目立たないようにしようとする人も少なくありません。
      普及が進む「フェイスブック」などのSNSでも、メッセージを書き込む際に、「いいね！」を押してほしいと思って、“受ける”メッセージを書いてしまう。
      押してもらえないと残念なので、迎合して、自分の真意でもないことを書く。
      インターネットやスマートフォンが普及して周囲とつながる機会が増える中、嫌われることを恐れる人が増えているように思います。
      だからこそ、嫌われる勇気というタイトルが一番響くのではないかと考えました。"
      fill_in 'review-text', with: text2
     
      # 編集してもカウントが変化しない
      expect{
        find('input[name="commit"]').click
      }.to change { Review.count }.by(0)
      # 投稿詳細ページに遷移
      expect(current_path).to eq review_path(@review1)
      # 投稿詳細ページには編集後の投稿が存在することを確認する（画像）
      expect(page).to have_selector ("img")


      # 投稿詳細ページには編集後の投稿が存在することを確認する（タイトル）
      expect(page).to have_content(title2)
      # 投稿詳細ページには編集後の投稿が存在することを確認する（投稿者名）
      expect(page).to have_content(@review1.user.name)
      # 投稿詳細ページには編集後の投稿が存在することを確認する（カテゴリー）
      expect(page).to have_content(@review1.category.name)
      # 投稿詳細ページには編集後の投稿が存在することを確認する（テキスト）
      expect(page).to have_content(text2)
    end
  end


  context '投稿編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した投稿の編集画面には遷移できない' do

      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @review1.user.email
      fill_in 'Password', with: @review1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      
      # 投稿2の詳細画面に遷移
      visit review_path(@review2)
      
      # 投稿2にEditリンクがないことを確認する
      expect(page).to have_no_link 'Edit', href: edit_review_path(@review2)
      
    end
    it 'ログインしていないと投稿を見ることができない(投稿一覧画面へのリンクが存在しない為、投稿詳細画面及び編集画面に遷移できない)' do
      # トップページにいる
      visit root_path
      expect(page).to have_no_link 'Review', href: reviews_path
    end
  end
end


RSpec.describe '投稿削除', type: :system do
  before do
    @review = FactoryBot.create(:review)
    sleep 0.2
  end
  context '投稿削除ができるとき' do
    
    it 'ログインしたユーザーは自分の投稿が削除できる' do
      #投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @review.user.email
      fill_in 'Password', with: @review.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿詳細画面に遷移
      visit review_path(@review)
      # 投稿にDeleteリンクがあることを確認する
      expect(page).to have_link 'Delete', href: review_path(@review)
      # DeleteボタンをクリックするとReviewモデルのカウントが１減る事を確認
      expect{
        find_link('Delete', href: review_path(@review)).click
      }.to change { Review.count }.by(-1)
      expect(current_path).to eq reviews_path
    end

    it 'ユーザーは自分以外の投稿削除ができない' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @review.user.email
      fill_in 'Password', with: @review.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_link 'Delete', href: review_path(@review)
    end

    it 'ログインしていないと投稿を見ることができない(投稿一覧画面へのリンクが存在しない為、投稿詳細画面への遷移及び削除ができない)' do
      # トップページにいる
      visit root_path
      expect(page).to have_no_link 'Review', href: reviews_path
    end
  end


  RSpec.describe '投稿削除', type: :system do
    context '投稿削除ができるとき' do
      before do
        @review = FactoryBot.create(:review)
        sleep 0.2
      end
    end
  end

end