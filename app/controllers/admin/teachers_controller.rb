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
    @teacher.profile.build_address
    @teacher.profile.build_tax_code

    @subject_names, @school_options, @roles_names = prepare_data @teacher
  end  
  
  def create
    return redirect_to(admin_teachers_path(), notice: "Створення профілю відмінено користувачем") if params[:commit] == 'Відміна'
    teacher = Teacher.new do |t|
      t.email                 = create_params[:email]
      t.username              = create_params[:username]
      t.password              = create_params[:password]
      t.password_confirmation = create_params[:password_confirmation]
      t.school_id             = create_params[:school_id]
      t.build_profile(create_params[:profile_attributes])
      if create_params.key?("a_class_level") && create__params.key?("a_class_parallel")
        a_class = AcademicClass.find_by(academic_class_level: create_params[:a_class_level], academic_class_parallel: create_params[:a_class_parallel]).id  
        t.academic_class_id = a_class.id
      end   
      create_params[:subjects_attributes].each do |k, v|
        t.subjects << Subject.find(v[:id])  
      end   
      create_params[:roles_attributes].each do |k, v|
        t.roles << Role.find(v[:id])
      end  
    end  
    if teacher.save   
      redirect_to admin_teachers_path(), notice: "Профіль викладача успішно створено!" and return
    else
      redirect_to admin_teachers_path(), alert: "Помилка створення профіля викладача!" and return
    end   
  end  

  def edit
    @teacher = Teacher.find(edit_params[:id])
    if @teacher.role?('class_manager')
      academic_class = AcademicClass.find(@teacher.academic_class_id)
      @a_class_level = academic_class.academic_class_level
      @a_class_parallel = academic_class.academic_class_parallel
    end
    
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

    if update_params.key?("a_class_level") && update_params.key?("a_class_parallel")
      a_class = AcademicClass.find_by(academic_class_level: create_params[:a_class_level], academic_class_parallel: create_params[:a_class_parallel])
      @teacher.academic_class_id = a_class.id
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

  def import_teachers
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
    params.require(:teacher).permit(:email, :username, :password, :password_confirmation, :school_id, :a_class_level, :a_class_parallel,
      subjects_attributes: [:id], roles_attributes: [:id], profile_attributes: [:first_name, :last_name, :birth_date, 
      phones_attributes: [:phone_num], address_attributes: [:address_string], tax_code_attributes: [:ptc]])
  end  

  def update_params
    params.require(:teacher).permit(:email, :username, :password, :password_confirmation, :school_id,  :a_class_level, :a_class_parallel,
      subjects_attributes: [:id, :_destroy], roles_attributes: [:id, :_destroy], profile_attributes: [:id, :first_name, :last_name, :birth_date, 
      phones_attributes: [:phone_num, :id], address_attributes: [:address_string, :id], tax_code_attributes: [:ptc, :id]])
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
    subjects  = Subject.all.map{|sn| [[sn.description, sn.level].join(' ') + 'клас', sn.id]}
    relation  = if current_user.role?(:admin) then School.all else School.find(current_user.school_id) end
    schools   = relation.map{|so| [so.school_name, so.id]} unless relation.nil? 
    roles     = Role.where.not(rolename: 'admin' ).map{|rs| [rs.rolename, rs.id]}
    [subjects, schools, roles]
  end  
end
