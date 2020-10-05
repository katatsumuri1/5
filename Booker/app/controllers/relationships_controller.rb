class RelationshipsController < ApplicationController


  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    # current_user.active_relationships.create(followed_id: user.id)
    redirect_back(fallback_location: users_path)
  end

  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    redirect_back(fallback_location: users_path)
  end
end