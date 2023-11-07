class User < ApplicationRecord
    has_secure_password
    has_many :courses, dependent: :destroy
    has_many :attendance, dependent: :destroy

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 8 }
end
