require 'data_import'

class Admin::SchoolsController < ApplicationController
  authorize_resource
  
  def index
    @school = School.new
    if current_user.role?(:admin)
      @schools = School.all.order('id ASC').paginate(page: index_params[:page], per_page: 15)
    else
      @schools = School.find(current_user.school_id).paginate(page: index_params[:page], per_page: 15)
    end    
  end

  def new
    @school = School.new
  end   

  def show
    @school = School.find(edit_params[:id])
  end  

  def edit
    @school = School.find(edit_params[:id])
  end   

  def create
    return redirect_to(admin_schools_path(), notice: "Створення профілю школи відмінено користувачем") if params[:commit] == 'Відміна'

    school = School.new(create_params)

    if school.save   
      redirect_to admin_schools_path(), notice: "Профіль школи успішно створено!" and return
    else
      redirect_to admin_schools_path(), alert: "Помилка створення профілю школи!" and return
    end   
  end 

  def update
    return redirect_to(admin_schools_path(), notice: "Редагування відмінено користувачем") if params[:commit] == 'Відміна'

    school = School.find(edit_params[:id])

    if school.update_attributes(update_params)
      return redirect_to admin_schools_path(), notice: "Профіль школи успішно оновлено!"
    else
      redirect_to admin_schools_path(), alert: "Помилка оновлення профіля!"
    end  
  end 

  def import_school
    # Serve uploaded data file
    uploaded_file = upload_params[:school_data]
    File.open(Rails.root.join('data', uploaded_file.original_filename), 'wb') do |file|
      file.write(uploaded_file.read)
    end  

    # Import data
    DataImport::school_import(['data/', uploaded_file.original_filename].join)    
    
    # Removing data file
    File.delete(Rails.root.join('data', uploaded_file.original_filename))
    
    return redirect_to(admin_schools_path(), notice: "Дані школи імпортовані успішно!")
  end  


  private
  def create_params
    params.require(:school).permit(:school_code, :school_name, :school_address_string, :school_email, :school_phone)
  end 

  def update_params
    params.require(:school).permit(:id, :school_code, :school_name, :school_address_string, :school_email, :school_phone)
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

  def upload_params
    params.require(:school).permit(:school_data)
  end  
end
