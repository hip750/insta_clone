require 'test_helper'

class ImagepostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @imagepost = imageposts(:orange)
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Imagepost.count' do
      post imageposts_path, params: { imagepost: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Imagepost.count' do
      delete imagepost_path(@imagepost)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong imagepost" do
    log_in_as(users(:michael))
    imagepost = imageposts(:ants)
    assert_no_difference 'Imagepost.count' do
      delete imagepost_path(imagepost)
    end
    assert_redirected_to root_url
  end
end
