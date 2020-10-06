class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  attachment :profile_image
  validates :name, presence: true, length: { minimum: 2 , maximum: 20 }
  validates :introduction, length: { maximum: 50 }
  
  def self.search_user(search,word)
      if search == "forward_match"
          @user = User.where(["name LIKE?","#{word}%"])
      elsif search == "backward_match"
           @user = User.where(["name LIKE?","%#{word}"])
      elsif search == "perfect_match"
          @user = User.where(name:"word")
      elsif search == "partial_match"
          @user = User.where(["name LIKE?","%#{word}%"])
      else
           User.all
      end
  end
     # ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)

    # self.active_relationships.create(followed_id: other_user.id)

    # current_user.follow(@user)
    # current_user.active_relationships.create(followed_id: @user.id)
    # Relationsip.create(follower_id: urrent_user.id, followed_id: @user.id)
  end

  # ユーザーをアンフォローする
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
  
end
