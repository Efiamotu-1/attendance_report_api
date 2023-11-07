class CoursesController < ApplicationController
    before_action :authorize
    before_action :read_course, only: %i[show update destroy]

    def index
        render json: @user.courses
    end

    def course_reports
        @course = Course.find(params[:id])
        render json: @course.attendance
    end

    def show
        @course = Course.find(params[:id])
        render json: @course
    end

    def create
        @course = Course.new(course_params)
        @course.user = @user
        if @course.save
            render json: {status: 'success', data: @course}
        else
            render json: {error: 'Invalid Details', status: 'unauthorized', error_message: @course.errors.full_messages }
        end
            
    end

    def update
        unless @user == Course.find(params[:id]).user
            return render json: { error: 'You are not allowed because you did not create the Course', status: :unauthorized }
        end
        if @course.update(course_params)
            render json: {status: 'success', data: @course}
        else
            render json: {error: 'Invalid Details', status: 'unauthorized', error_message: @course.errors.full_messages }
        end
    end

    def destroy
        unless @user == Course.find(params[:id]).user
            return render json: { error: 'You are not allowed because you did not create the Course', status: :unauthorized }
        end
        if @course.destroy
            render json: { id: @course.id, message: 'Course deleted successfully' }
        else
            render json: @course.errors.full_messages
        end
    end

    private

    def read_course
        @course = Course.find(params[:id])
    end

    def course_params
        params.require(:course).permit(:course_title, :course_description, :course_priority, :department)
    end
end