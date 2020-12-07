require 'rails_helper'

RSpec.describe 'ツイート投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    
  end
  context 'ツイート投稿ができるとき'do
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
      
      # カテゴリーIDを選択
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
  context 'ツイート投稿ができないとき'do
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