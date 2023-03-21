class Item < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one :order
  has_many :comments, dependent: :destroy

  validates :images, presence: true
  validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }
  validates :title, presence: true
  validates :explanation, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :delivery_day
  belongs_to :prefecture

  with_options presence: true do
    validates :category_id
    validates :condition_id
    validates :delivery_charge_id
    validates :prefecture_id
    validates :delivery_day_id
    validates :price,
              numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'は¥300〜9,999,999の間で設定してください' }
  end

  def self.search(search)
    return Item.all unless search
    Item.where(['title LIKE ?', "%#{search}%"])
  end
end
