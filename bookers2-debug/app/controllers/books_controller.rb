class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @book1 = Book.new
    @user = current_user
    @p1 = "Create Book"
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    @p1 = "Create Book"
  end

  def create
    @book = Book.new(book_params)
    @user = current_user
    @books = Book.all
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      render "index"
    end
  end

  def edit
    @book = Book.find(params[:id])
    @p1 = "Update Book"
    if @book.user == current_user
     render "edit"
    else
     redirect_to books_path
    end
  end



  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
