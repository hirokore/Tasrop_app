class Contact < ApplicationRecord
    # validate
    validates :name, length: { maximum: 16 }, presence: true
    validates :title, length: { maximum: 32 }, presence: true
    validates :email, length: { maximum: 254 }, presence: true
    validates :content, length: { maximum: 254 },presence: true
end
