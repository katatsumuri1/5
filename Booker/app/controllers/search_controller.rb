class SearchController < ApplicationController
  def search
        @range = params[:range]
        search = params[:search]
        word = params[:word]
        if @range == '1'
            @user = User.search_user(search,word)
        else
             #@book = Book.where('title like ?', '初投稿%')
           @book = Book.search_method(search,word)
        end
  end
end
