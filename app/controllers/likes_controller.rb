class LikesController < ApplicationController
  def create
    @imagepost = Imagepost.find(params[:imagepost_id])
    @like = current_user.likes.build(imagepost_id: params[:imagepost_id])
    @like.save
  end

  def destroy
    @imagepost = Imagepost.find(params[:imagepost_id])
    @like = Like.find_by(imagepost_id: params[:imagepost_id], user_id: current_user.id)
    @like.destroy
  end
end
