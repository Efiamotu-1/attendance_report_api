class Attendance < ApplicationRecord
    belongs_to :user
    belongs_to :course
    
    validates :course_id, presence: true
    validates :class_held, presence: true
    validates :class_attended, presence: true 
    validates :class_date, presence: true
end
