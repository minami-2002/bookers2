class BooksController < ApplicationController
  
  before_action :authenticate_user!
  
  def index
    @books = Book.all
    @user = current_user
    @book = Book.new
  end
  
  def create
   @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @books = Book.all
    if @book.save
     redirect_to book_path(@book), notice: 'You have created book successfully.'
    else
     render :index
    end 
    
  end
  
  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  def edit
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    redirect_to book_path(@book), notice: 'You have updated book successfully.'
    else
    render :edit
    end
  
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  private
  
  def book_params
    params.require(:book).permit(:id, :image_id, :title, :body)
  end
  

end
