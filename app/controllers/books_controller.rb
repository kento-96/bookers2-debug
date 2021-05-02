class BooksController < ApplicationController
 before_action :authenticate_user!

  def show
    @new = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def index
    @books = Book.all
    @user = User.find(current_user.id)
    @book=Book.new
  end

  def create
    @book = Book.new(book_params)
    @user=User.find(current_user.id)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render"edit"
    else
      redirect_to books_path
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

end
