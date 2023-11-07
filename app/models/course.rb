class Course < ApplicationRecord
    belongs_to :user, class_name: 'User', foreign_key: 'user_id'
    has_many :attendance, dependent: :destroy
    validates :course_title, presence: true
    validates :course_description, presence: true
    validates :department, presence: true
end
