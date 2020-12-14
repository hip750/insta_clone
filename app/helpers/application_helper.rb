module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Insta Clone App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # descriptions
  def default_meta_tags
    { site: 'Insta Clone App',
      title: 'Insta Clone App',
      reverse: true,
      separator: '|',
      description: 'Insta Clone Appは好きな写真を投稿してみんなでシェアできる無料SNSです。',
      keywords: 'SNS, 写真, 画像, シェア',
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      og: {
        site_name: 'Insta Clone App',
        title: 'Insta Clone App',
        description: 'Insta Clone Appは好きな写真を投稿してみんなでシェアできる無料SNSです。', 
        type: 'website',
        url: request.original_url,
        image: image_url('insta_top.jpg'),
        locale: 'ja_JP',
      }
    }
  end

  def notification_form(notification)
    @visitor = notification.visitor
    @comment = nil
    your_imagepost = link_to 'あなたの投稿', imagepost_path(notification),
                                        style:"font-weight: bold;"
    @visitor_comment = notification.comment_id
    #notification.actionがfollowかlikeかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visitor.name, href: users_path(@visitor),
                                          style: "font-weight: bold;")
        + "があなたをフォローしました"
      when "like" then
        tag.a(notification.visitor.name, href: users_path(@visitor),
                                          style: "font-weight: bold;")
        + "が" + tag.a('あなたの投稿', href: imagepost_path(notification.imagepost_id),
                                        style: "font-weight: bold;")
        + "にいいねしました"
      when "comment" then
        @comment = Comment.find_by(id: @visitor_comment)&.content
        tag.a(@visitor.name, href:users_path(@visitor),
                              style:"font-weight: bold;")
        + "が" + tag.a('あなたの投稿', href: imagepost_path(notification.imagepost_id),
                                        style: "font-weight: bold;")
        + "にコメントしました"
    end
  end
  
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
  
end
