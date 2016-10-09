class Admin::TeachersController < ApplicationController
  authorize_resource

  def index
    if current_user.role?(:admin)
      @teachers = Teacher.all.order('school_id ASC').paginate(page: index_params[:page], per_page: 15)
    else
      @teachers = Teacher.where("school_id = #{current_user.school_id}").paginate(page: index_params[:page], per_page: 15)
    end    
  end

  def new
    @teacher = Teacher.new
    @teacher.build_profile
    @teacher.profile.phones.build

    @subject_names, @school_options, @roles_names = prepare_data @teacher
  end  
  
  def create
    return redirect_to(admin_teachers_path(), notice: "Створення профілю відмінено користувачем") if params[:commit] == 'Відміна'
    teacher = Teacher.new(create_params)
    create_params[:subjects_attributes].each do |k, v|
      teacher.subjects << Subject.find(v[:id])  
    end   
    create_params[:roles_attributes].each do |k, v|
      teacher.roles << Role.find(v[:id])
    end  

    if teacher.save   
      redirect_to admin_teachers_path(), notice: "Профіль викладача успішно створено!" and return
    else
      redirect_to admin_teachers_path(), alert: "Помилка створення профіля викладача!" and return
    end   
  end  

  def edit
    @teacher = Teacher.find(edit_params[:id])
   
    @subject_names, @school_options, @roles_names = prepare_data @teacher
  end  

  def update
    return redirect_to(admin_teachers_path(), notice: "Редагування відмінено користувачем") if params[:commit] == 'Відміна'

    @teacher = Teacher.find(edit_params[:id])

    @teacher.subjects.delete_all
    update_params[:subjects_attributes].each do |key, val|
      @teacher.subjects << Subject.find(val[:id]) unless val[:id].blank?
    end

    @teacher.roles.delete_all
    update_params[:roles_attributes].each do |key, val|
      @teacher.roles << Role.find(val[:id])
    end  
    
    if @teacher.update_attributes(update_params)
      return redirect_to admin_teachers_path(), notice: "Профіль викладача успішно оновлено!"
    else
      redirect_to admin_teachers_path(), alert: "Помилка оновлення профіля!"
    end  
  end

  def show
    @teacher = Teacher.find(edit_params[:id])
  end  

  def destroy
    @teacher = Teacher.find(edit_params[:id])
    @teacher.roles.delete_all
    @teacher.subjects.delete_all
    @teacher.destroy

    redirect_to admin_teachers_path(), notice: "Профіль викладача успішно видалено!" and return
  end 

  def update_subjects
    @subject = Subject.find(params[:idx])
    @current = SecureRandom.uuid.gsub("-", "").hex
    respond_to do |format|
      format.js { render action: "update_subjects" }
    end   
  end 

  def update_roles
    @role    = Role.find(params[:idr])
    @current = SecureRandom.uuid.gsub("-", "").hex
    respond_to do |format|
      format.js { render action: "update_roles" }
    end  
  end  

  def update_phones
    @phone_num  = params[:p_num]
    @current    = SecureRandom.uuid.gsub("-", "").hex
    respond_to do |format|
      format.js { render action: "update_phones"}
    end  
  end  

  def import_teachers
    # to do import...
    redirect_to admin_teachers_path(), notice: "Дані успішно імпортовано!" and return
  end  

  protected
  def creation_error_handler
    redirect_to admin_teachers_path(), alert: "Помилка створення профіля!"
  end 

  private
  #=========================================================================
  # Create and update parameters. Methods names MUST be exactly as follows
  #=========================================================================
  def create_params
    params.require(:teacher).permit(:email, :username, :password, :password_confirmation, :school_id, subjects_attributes: [:id], roles_attributes: [:id], 
      profile_attributes: [:first_name, :last_name, :birth_date, :academic_class, :academic_parallel, :address_string, :ptc,
      phones_attributes: [:phone_num]])
  end  

  def update_params
    params.require(:teacher).permit(:email, :username, :password, :password_confirmation, :school_id, subjects_attributes: [:id, :_destroy], roles_attributes: [:id, :_destroy], 
      profile_attributes: [:id, :first_name, :last_name, :birth_date, :academic_class, :academic_parallel, :address_string, :ptc, 
      phones_attributes: [:phone_num, :id]])
  end

  #=========================================================================
  # Auxiliary methods 
  #=========================================================================
  def edit_params
    params.permit(:id)
  end 

  def index_params
    params.permit(:page)
  end  

  def prepare_data(teacher)
    subjects  = Subject.all.map{|sn| [[sn.name, sn.level].join(' ') + 'клас', sn.id]}
    relation  = if current_user.role?(:admin) then School.all else School.find(current_user.school_id) end
    schools   = relation.map{|so| [so.school_name, so.id]} unless relation.nil? 
    roles     = Role.where.not(rolename: 'admin' ).map{|rs| [rs.rolename, rs.id]}
    [subjects, schools, roles]
  end  
end
