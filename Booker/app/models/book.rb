class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
     def self.search_method(search,word)
        if search == 'forward_match'
             @book = Book.where(['title like ?', "#{word}%"])
        elsif search == 'backward_match'
             @book = Book.where(['title like ?', "%#{word}"])
        elsif search == 'perfect_match'
             @book = Book.where(title: word)
        elsif search == 'partial_match'
             @book = Book.where(['title like ?',"%#{word}%"])
        else
             @book = Book.all
        end
     end

  
 validates :title, presence: true
 validates :body, presence: true, length: { maximum: 200 }
end
