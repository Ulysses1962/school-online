class Admin::StudentsController < ApplicationController
  authorize_resource

  def index
    if current_user.role?(:admin)
      @students = Student.all.order('school_id ASC').paginate(page: index_params[:page], per_page: 15)
    else
      @students = Student.where("school_id = #{current_user.school_id}").paginate(page: index_params[:page], per_page: 15)
    end    
  end

  def new
    @student = Student.new
    @student.build_profile
    @student.profile.phones.build

    @school_options = prepare_data
  end  
  
  def create
    return redirect_to(admin_students_path(), notice: "Створення профілю відмінено користувачем") if params[:commit] == 'Відміна'
    student = Student.new(create_params)
    student.roles << Role.find_by_rolename('student')

    if student.save   
      redirect_to admin_students_path(), notice: "Профіль учня успішно створено!" and return
    else
      redirect_to admin_students_path(), alert: "Помилка створення профілю учня!" and return
    end   
  end  

  def edit
    @student = Student.find(edit_params[:id])
   
    @school_options = prepare_data
  end  

  def update
    return redirect_to(admin_students_path(), notice: "Редагування відмінено користувачем") if params[:commit] == 'Відміна'

    @student = Student.find(edit_params[:id])

    if @student.update_attributes(update_params)
      return redirect_to admin_students_path(), notice: "Профіль учня успішно оновлено!"
    else
      redirect_to admin_students_path(), alert: "Помилка оновлення профіля!"
    end  
  end

  def show
    @student = Student.find(edit_params[:id])
  end  

  def destroy
    @student = Student.find(edit_params[:id])
    @student.roles.delete_all
    @student.destroy
    # Destroy all marks record of deleted student

    redirect_to admin_students_path(), notice: "Профіль викладача успішно видалено!" and return
  end 

  def update_phones
    @phone_num  = params[:p_num]
    @current    = SecureRandom.uuid.gsub("-", "").hex
    respond_to do |format|
      format.js { render action: "update_phones"}
    end  
  end  

  def import_students
    # Serve uploaded data file
    uploaded_file = upload_params[:school_data]
    File.open(Rails.root.join('data', uploaded_file.original_filename), 'wb') do |file|
      file.write(uploaded_file.read)
    end  

   # Import data
    DataImport::import_students(['data/', uploaded_file.original_filename].join)    

    # Removing data file
    File.delete(Rails.root.join('data', uploaded_file.original_filename))
    redirect_to admin_students_path(), notice: "Дані успішно імпортовано!" and return
  end  

  protected
  def creation_error_handler
    redirect_to admin_students_path(), alert: "Помилка створення профіля!"
  end 

  private
  #=========================================================================
  # Create and update parameters. Methods names MUST be exactly as follows
  #=========================================================================
  def create_params
    params.require(:teacher).permit(:email, :username, :password, :password_confirmation, :school_id, :parent_name
      profile_attributes: [:first_name, :last_name, :birth_date, :academic_class, :academic_parallel, :address_string, :personal_file_code,
      phones_attributes: [:phone_num]])
  end  

  def update_params
    params.require(:teacher).permit(:email, :username, :password, :password_confirmation, :school_id, :parent_name 
      profile_attributes: [:id, :first_name, :last_name, :birth_date, :academic_class, :academic_parallel, :address_string, :personal_file_code, 
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

  def prepare_data
    relation  = if current_user.role?(:admin) then School.all else School.find(current_user.school_id) end
    schools   = relation.map{|so| [so.school_name, so.id]} unless relation.nil? 
    [schools]
  end  
end
