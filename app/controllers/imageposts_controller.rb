class ImagepostsController < ApplicationController
  before_action :logged_in_user, only: [:search, :create, :destroy]
  before_action :correct_user,   only: :destroy

  def show
    @imagepost = Imagepost.find(params[:id])
    @comments = @imagepost.comments
    @comment = Comment.new
  end

  def create
    @imagepost = current_user.imageposts.build(imagepost_params)
    @imagepost.image.attach(params[:imagepost][:image])
    if @imagepost.save
      flash[:success] = "投稿に成功しました！"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @imagepost.destroy
    flash[:success] = "投稿を削除しました。"
    redirect_to request.referrer || root_url
  end

  def search
    @imageposts = Imagepost.search(params[:search]) 
  end

  private

    def imagepost_params
      params.require(:imagepost).permit(:image, :content)
    end

    def correct_user
      @imagepost = current_user.imageposts.find_by(id: params[:id])
      redirect_to root_url if @imagepost.nil?
    end
end