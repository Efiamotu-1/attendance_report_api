class AttendanceController < ApplicationController
    before_action :authorize
    before_action :read_attendance, only: %i[show update destroy]

    def index
        render json: @user.attendance
    end

    def create
        @attendance = Attendance.new(attendance_params)
        @attendance.user = @user
        if @attendance.save
            @course = Course.where(id: params[:attendance][:course_id])
            class_held_data = @course[0].num_of_classes_held + params[:attendance][:class_held]
            class_attended_data = @course[0].num_of_classes_attended + params[:attendance][:class_attended]
            @course.update(num_of_classes_held: class_held_data, num_of_classes_attended: class_attended_data)
            course_percentage = (@course[0].num_of_classes_attended + 0.0) / (@course[0].num_of_classes_held + 0.0) * 100.0
            @course.update(percentage: course_percentage)
            render json: {status: 'success', data: @attendance}
        else
            render json: {error: 'Invalid Details', status: 'unauthorized', error_message: @attendance.errors.full_messages }
        end        
    end

    def destroy
      unless @user == Attendance.find(params[:id]).user
        return render json: { error: 'You are not allowed because you did not create the Attendance', status: :unauthorized }
      end
      if @attendance.destroy
        render json: { id: @attendance.id, message: 'Attendance deleted successfully' }
      else
        render json: @attendance.errors.full_messages
      end
    end

private

  def read_attendance
    @attendance = Attendance.find(params[:id])
  end

  def attendance_params
    params.require(:attendance).permit(:class_date, :class_attended, :class_held, :course_id)
  end
end