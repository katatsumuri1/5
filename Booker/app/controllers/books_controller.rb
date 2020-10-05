class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save 
      flash[notice] = 'Book was successfully created.'
      redirect_to book_path(@book.id) 
    else
      @books = Book.all
      render :index
    end   
  end

  def index 
    @book =Book.new
    @books = Book.all
    @user = @book.user
    @users= User.all
    
  end 
   
  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books = Book.new
    @book_comment = BookComment.new
    
  end  
  
  def edit
    @book= Book.find(params[:id])
    if current_user != @book.user
    redirect_to books_path
    end
  end  
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path 
  end 
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: 'Book was successfully update.'
    else
    render :edit
    end
  end
  
  
  
  
  private

   def book_params
    params.require(:book).permit(:title,:body)
   end
   
end
