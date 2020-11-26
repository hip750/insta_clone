require 'test_helper'

class ImagepostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "imagepost interface" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select 'div.pagination'
    # 無効な送信
    assert_no_difference 'Imagepost.count' do
      post imageposts_path, params: { imagepost: { content: "" } }
    end
    assert_select 'div#error_explanation'
    assert_select 'a[href=?]', '/?page=2'  # 正しいページネーションリンク
    # 有効な送信
    content = "有効な投稿"
    assert_difference 'Imagepost.count', 1 do
      post imageposts_path, params: { imagepost: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # 投稿を削除する
    assert_select 'a', text: '削除'
    first_imagepost = @user.imageposts.paginate(page: 1).first
    assert_difference 'Imagepost.count', -1 do
      delete imagepost_path(first_imagepost)
    end
    # 違うユーザーのプロフィールにアクセス（削除リンクがないことを確認）
    get user_path(users(:archer))
    assert_select 'a', text: '削除', count: 0
  end
end
