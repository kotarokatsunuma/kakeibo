require 'rails_helper'

RSpec.describe '家計簿投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @book = FactoryBot.build(:book)
  end
  context '家計簿投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('+新規')
      # 投稿ページに移動する
      visit new_book_path
      # フォームに情報を入力する
      fill_in 'book_year', with: @book.year
      fill_in 'book_month', with: @book.month
      fill_in 'book_category', with: @book.category
      fill_in 'book_amount', with: @book.amount
      # 送信するとBookモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Book.count }.by(1)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容が存在することを確認する
      expect(page).to have_content(@book.year)
      expect(page).to have_content(@book.month)
      expect(page).to have_content(@book.category)
      expect(page).to have_content(@book.amount)
    end
  end
  context '家計簿投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content('+新規')
    end
  end
end
