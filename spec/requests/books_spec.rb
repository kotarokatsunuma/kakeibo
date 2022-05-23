require 'rails_helper'
describe BooksController, type: :request do

  before do
    @book = FactoryBot.create(:book)
  end

  describe 'GET #index' do
    it 'indexアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのmonthが存在する' do 
      get root_path
      expect(response.body).to include("#{@book.month}")
    end
    it 'indexアクションにリクエストするとレスポンスに投稿済みのamountが存在する' do 
      get root_path
      expect(response.body).to include("#{@book.amount}")
    end
  end

  describe 'GET #create' do
    it 'createアクションにリクエストすると正常にレスポンスが返ってくる' do 
      get books_path(@book)
      expect(response.status).to eq 200
    end
    it 'createアクションにリクエストするとレスポンスに投稿済みのmonthが存在する' do 
      get books_path(@book)
      expect(response.body).to include("#{@book.month}")
    end
    it 'createアクションにリクエストするとレスポンスに投稿済みのamountが存在する' do 
      get books_path(@book)
      expect(response.body).to include("#{@book.amount}")
    end
    
  end 
end
