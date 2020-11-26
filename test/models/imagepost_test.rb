require 'test_helper'

class ImagepostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @imagepost = @user.imageposts.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @imagepost.valid?
  end

  test "user id should be present" do
    @imagepost.user_id = nil
    assert_not @imagepost.valid?
  end

  test "content should be present" do
    @imagepost.content = " "
    assert_not @imagepost.valid?
  end

  test "content should not be too long" do
    @imagepost.content = "a" * 141
    assert_not @imagepost.valid?
  end

  test "order should be most recent first" do
    assert_equal imageposts(:most_recent), Imagepost.first
  end
end
