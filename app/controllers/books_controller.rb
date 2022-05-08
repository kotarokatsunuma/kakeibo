class BooksController < ApplicationController
  before_action :set_book, only:[:show,:edit,:update,:destroy]
  before_action :move_to_index, except: [:index, :show]


  def index
    @books = Book.all
    @books = @books.where(year: params[:year]) if params[:year].present?
    @books = @books.where(month: params[:month])if params[:month].present?
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    Book.new(book_params)
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "家計簿に#{@book.year}年#{@book.month}月データを1件登録しました"
      redirect_to books_path
    else
      flash.now[:alert] = "登録に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update
    Book.new(book_params)
    if @book.update(book_params)
      flash[:notice] = "データを1件更新しました"
      redirect_to book_path
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @book.destroy
    flash[:notice] = "削除しました"
    redirect_to books_path
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end
  
  def book_params
    params.require(:book).permit(:year,:month,:inout,:category,:amount)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end