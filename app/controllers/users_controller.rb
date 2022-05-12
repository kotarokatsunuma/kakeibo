class UsersController < ApplicationController
  
  
  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @books = user.books

    
    @books = @books.where(year: params[:year]) if params[:year].present?
    @books = @books.where(month: params[:month])if params[:month].present?
  end

  

end