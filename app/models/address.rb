class Address < ApplicationRecord
  belongs_to :order


    validates :postal_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
    validates :telephone, presence: true, format: { with: /\A\d{10}$|^\d{11}\z/ , message: "is invalid."}
    validates :city, presence: true
    validates :house_number, presence: true
  
end
