class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @imagepost  = current_user.imageposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def terms_of_service
  end

  def privacy_policy
  end
end
