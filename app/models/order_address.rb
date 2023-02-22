class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone, :user_id, :item_id, :token

  with_options presence: true do
  validates :token
  validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
  validates :city
  validates :house_number
  validates :user_id
  validates :item_id
  validates :telephone, format: { with: /\A\d{10}$|^\d{11}\z/ , message: "is invalid."}
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, telephone: telephone, order_id: order.id)
  end

end