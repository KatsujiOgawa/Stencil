require 'rails_helper'

RSpec.describe 'コメント投稿', type: :system do
  before do
    @review = FactoryBot.create(:review)
    @comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーは投稿詳細ページでコメント投稿できる' do
    # ログインする
    visit new_user_session_path
    fill_in 'Email', with: @review.user.email
    fill_in 'Password', with: @review.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # 投稿詳細ページに遷移する
    visit review_path(@review)
    # フォームに情報を入力する
    fill_in 'comment[comment]', with: @comment
    # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)
    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq review_path(@review)
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content @comment
  end
end