class Relationship < ApplicationRecord
  belongs_to:follower, class_name: "User"
  belongs_to:followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
     
    #   add_index :relationships, :follower_id
    # add_index :relationships, :followed_id
    # add_index :relationships, [:follower_id, :followed_id], unique: true
end
