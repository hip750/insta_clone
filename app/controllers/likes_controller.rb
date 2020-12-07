class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(imagepost_id: params[:imagepost_id])
    @like.save
    @imagepost = Imagepost.find(params[:imagepost_id])
    @imagepost.create_notification_like(current_user)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end

  def destroy
    @imagepost = Imagepost.find(params[:imagepost_id])
    @like = Like.find_by(imagepost_id: params[:imagepost_id], user_id: current_user.id)
    @like.destroy
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end
end
