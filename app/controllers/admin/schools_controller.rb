require 'data_import'

class Admin::SchoolsController < ApplicationController
  ITEMS_PER_PAGE = 15

  authorize_resource
  
  def index
    if current_user.role?(:admin)
      @schools = School.all.order('id ASC').paginate(page: index_params[:page], per_page: ITEMS_PER_PAGE)
    else
      @schools = School.find(current_user.school_id)
    end    
  end

  def new
    @school = School.new
  end   

  def show
    @school = School.find(edit_params[:id])
    
    respond_to do |format|
      format.json { render json: @school }
    end  
  end  

  def edit
    @school = School.find(edit_params[:id])

    respond_to do |format|
      format.jason { render json: @school }
    end  
  end   

  def create
    return redirect_to(admin_schools_path(), notice: "Створення профілю школи відмінено користувачем") if params[:commit] == 'Відміна'
    @school = School.new(create_params)

    respond_to do |format|
      if @school.save
        format.html { redirect_to admin_schools_path(), notice: "Профіль школи успішно створено!" and return }
        format.json { render json: @school, status: :created }
      else
        format.html { redirect_to admin_schools_path(), alert: "Помилка створення профілю школи!" and return }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end    
    end  
  end 

  def update
    @school = School.find(edit_params[:id])

    if @school.update_attributes(update_params)
      render json: @school, status: :ok
    else
      render json: @school.errors, status: :unprocessable_entity
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
