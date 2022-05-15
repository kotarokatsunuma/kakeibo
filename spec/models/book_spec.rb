require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @book = FactoryBot.build(:book)
  end

  describe '家計簿の保存' do
    context '家計簿が投稿できる場合' do
      it '年、月、収支、科目、金額を投稿できる' do
        expect(@book).to be_valid
      end
      
    end
    context '家計簿が投稿できない場合' do
      it '年が空では投稿できない' do
        @book.year = ''
        @book.valid?
        expect(@book.errors.full_messages).to include("Year can't be blank")
      end     
      it '月が空では投稿できない' do
        @book.month = ''
        @book.valid?
        expect(@book.errors.full_messages).to include("Month can't be blank")
      end    
      it '収支が空では投稿できない' do
        @book.inout = ''
        @book.valid?
        expect(@book.errors.full_messages).to include("Inout can't be blank")
      end    
      it '科目が空では投稿できない' do
        @book.category = ''
        @book.valid?
        expect(@book.errors.full_messages).to include("Category can't be blank")
      end    
      it '金額が空では投稿できない' do
        @book.amount = ''
        @book.valid?
        expect(@book.errors.full_messages).to include("Amount can't be blank")
      end    
      it 'ユーザーが紐付いていなければ投稿できない' do
        @book.user = nil
        @book.valid?
        expect(@book.errors.full_messages).to include('User must exist')
      end
    end
  end
end
