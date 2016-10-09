class MarksController < ApplicationController
  authorize_resource

  def index
    if current_user.role?(:teacher) render_for_teacher and return
    if current_user.role?(:director) || current_user.role?(:deputy_director) render_for_deputy and return
    if current_user.role?(:student) render_for_student and return  
  end   

  private
  def create_params
  end 

  def update_params
  end

  # Auxiliary methods
  def render_for_teacher
  end

  def render_for_deputy
  end 

  def render_for_student
  end          
end
