class UsersController < ApplicationController

 before_action :authenticate_user!


 def edit
    @user = User.find(params[:id])
    if current_user != @user
    redirect_to user_path(current_user)
    end
 end

 def update
  @user = User.find(params[:id])
  if @user.update(user_params)
  redirect_to user_path(@user.id), notice:'You have updated user successfully.'
  else

  render :edit
  end
 end

 def show
  @user = User.find(params[:id])
  @book = Book.new
  @books = @user.books
 end

 def index
 @users = User.all
 @book =Book.new
 @user = current_user
 @relationship = current_user.active_relationships.find_by(followed_id: @user.id) 
 end

  def following
    @book  = Book.new
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following
    render :show_follow
  end

  def followers
    @book = Book.new
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render :show_follow
  end
 

private
 def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
 end

end
