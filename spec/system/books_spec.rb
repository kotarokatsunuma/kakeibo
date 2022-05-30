require 'rails_helper'

RSpec.describe '家計簿投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @book = FactoryBot.create(:book)
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
      # 投稿完了ページに遷移することを確認する
      expect(current_path).to eq(root_path)
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

RSpec.describe '家計簿編集', type: :system do
  before do
    @book1 = FactoryBot.create(:book)
    @book2 = FactoryBot.create(:book)
  end
  context '家計簿編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した家計簿の編集ができる' do
      # book1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @book1.user.email
      fill_in 'Password', with: @book1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # book1に「編集」へのボタンがあることを確認する
      expect(page).to have_content('編集')
      # 編集ページへ遷移する
      visit edit_book_path(@book1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#book_category').value
      ).to eq(@book1.category)
      #expect(
        #find(('#book_amount').value
      #).to eq(@book1.amount)
      # 投稿内容を編集する
      fill_in 'book_category', with: "#{@book1.category}+編集した給料"
      # 編集してもBookモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Book.count }.by(0)
      # 編集完了画面に遷移したことを確認する
      expect(current_path).to eq(root_path)
      # 「更新しました」の文字があることを確認する
      expect(page).to have_content('更新しました')
      # トップページには先ほど変更した内容のcategoryが存在することを確認する（テキスト）
      expect(page).to have_content("#{@book1.category}+編集した給料")
    end
  end
  context '家計簿編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した家計簿の編集画面には遷移できない' do
      # book1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @book1.user.email
      fill_in 'Password', with: @book1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      
      # book2に「book1」への編集ボタンがないことを確認する
      expect(page).to have_no_content('book1')
    end
    it 'ログインしていないと家計簿の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # book1,book2に「編集」へのボタンがないことを確認する
      expect{
        have_no_link('編集', href: book_path(@book1))
       }
       expect{
         have_no_link('編集', href: book_path(@book2))
        }
    end
  end
end

RSpec.describe '家計簿削除', type: :system do
  before do
    @book1 = FactoryBot.create(:book)
    @book2 = FactoryBot.create(:book)
  end
  context '家計簿削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した家計簿の削除ができる' do
      # book1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Email', with: @book1.user.email
      fill_in 'Password', with: @book1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # book1に「削除」のボタンがあることを確認する
      expect(page).to have_content('削除')
      # 投稿を削除するとレコードの数が1減ることを確認する    #「削除しました」の文字があることを確認する
      expect{
        page.accept_confirm do
          click_link('削除', href: book_path(@book1))
        end
        expect(page).to have_content('削除しました')  
      }.to change { Book.count }.by(-1)
      # 削除完了画面に遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページにはbook1の内容が存在しないことを確認する
      expect(page).to have_no_content("#{@book1.category}")
    end
  end
  context '家計簿削除ができないとき' do
    
    it 'ログインしていないと家計簿の削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # book1,book2に「削除」へのボタンがないことを確認する
      expect{
       have_no_link('削除', href: book_path(@book1))
      }
      expect{
        have_no_link('削除', href: book_path(@book2))
       }
    end
  end
end

RSpec.describe '家計簿詳細', type: :system do
  before do
    @book1 = FactoryBot.create(:book)
    @book2 = FactoryBot.create(:book)
  end
  it 'ログインしたユーザーは自らの家計簿詳細ページに遷移して表示される' do
    # book1を投稿したユーザーでログインする
    visit new_user_session_path
    fill_in 'Email', with: @book1.user.email
    fill_in 'Password', with: @book1.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # book1に「詳細」へのボタンがあることを確認する
    expect(page).to have_content('詳細')
    # 詳細ページに遷移する
    visit book_path(@book1)
    # 詳細ページに家計簿の内容が含まれている
    expect(page).to have_content("#{@book1.category}")
    
  end
  it 'ログインしていないと家計簿の詳細ボタンがない' do
    # トップページに移動する
    visit root_path
    # book1,book2に「編集」へのボタンがないことを確認する
    expect{
     have_no_link('編集', href: book_path(@book1))
    }
    expect{
      have_no_link('編集', href: book_path(@book2))
     }
    
  end
end