class ThematicPlansController < ApplicationController
  authorize_resource

  def index
    @subjects = Subject.all
    @thematic_plans = ThematicPlan.joins('subjects').where('school_id = ?', current_user.school_id)
    render component: 'ThematicPlans', props: { thematic_plans: @thematic_plans, subjects: @subjects }  
  end   

  private
  def create_params
    params.require(:thematic_plan).permit(:school_id, :subject_id, :academic_class, :academic_parallel, :theme_name)
  end 

  def update_params
    params.require(:thematic_plan).permit(:id, :school_id, :subject_id, :academic_class, :academic_parallel, :theme_name, :_destroy)
  end     
end
