class Imagepost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum:140}
  validates :image,   content_type: { in: %w[image/jpeg image/png],
                      message: "画像の拡張子は 'jpeg' もしくは 'png' のみ指定できます。" },
                      size:    { less_than: 5.megabytes,
                      message: "画像サイズは 5MB 以下で投稿してください。" }

  # 表示用のリサイズ済み画像を返す
  def display_image
    image.variant(resize_to_fit: [600, 600])
  end
end
