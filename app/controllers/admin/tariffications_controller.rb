class Admin::TarifficationsController < ApplicationController
  authorize_resource

  def index
    @tariffication  = Tariffication.new 
    @tariffications = Tariffication.where("user_id = #{index_params[:id]}")
    @teacher  = Teacher.find(index_params[:id])
  end

  def new
    @subjects = prepare_data
    @tariffication = Tariffication.new
  end 

  def create
    return redirect_to(admin_tariffications_path(create_params[:user_id]), notice: "Операцію відмінено користувачем") if params[:commit] == 'Відміна'
    tariffication = Tariffication.new(create_params)

    if tariffication.save   
      redirect_to admin_tariffications_path(create_params[:user_id]), notice: "Тарифікацію викладача успішно створено!" and return
    else
      redirect_to admin_tariffications_path(create_params[:user_id]), alert: "Помилка створення тарифікації викладача!" and return
    end   
  end 

  def show
    @tariffication = Tariffication.find(edit_params[:id])
  end 

  def edit
    @tariffication = Tariffication.find(edit_params[:id])
    @subject_names = prepare_data
  end 

  def update
    return redirect_to(admin_tariffications_path(update_params[:user_id]), notice: "Редагування відмінено користувачем") if params[:commit] == 'Відміна'
    @tariffication = Tariffication.find(update_params[:id])
    
    if @tariffication.update_attributes(update_params)
      return redirect_to admin_tariffications_path(update_params[:user_id]), notice: "Тарифікацію викладача успішно оновлено!"
    else
      redirect_to admin_tariffications_path(), alert: "Помилка оновлення тарифікації викладача!"
    end  
  end 

  def destroy
    @tariffication = Tariffication.find(update_params[:id])
    @tariffication.destroy

    redirect_to admin_tariffications_path(update_params[:user_id]), notice: "Тарификацію викладача успішно видалено!" and return
  end           

  def import_tariffications
    # Serve uploaded data file
    uploaded_file = upload_params[:school_data]
    File.open(Rails.root.join('data', uploaded_file.original_filename), 'wb') do |file|
      file.write(uploaded_file.read)
    end  

    # Import data
    DataImport::import_tariffication(['data/', uploaded_file.original_filename].join)    
    
    # Removing data file
    File.delete(Rails.root.join('data', uploaded_file.original_filename))

    redirect_to admin_teachers_path(), notice: "Дані тарифікації успішно імпортовано!" and return
  end 

  private
  
  def create_params
    params.require(:tariffication).permit(:user_id, :subject_id, :academic_year, :academic_class, :academic_parallel, :academic_group)
  end   

  def update_params
    params.require(:tariffication).permit(:id, :_destroy, :user_id, :subject_id, :academic_year, :academic_class, :academic_parallel, :academic_group)
  end 

  def index_params
    params.permit(:id)
  end  

  def edit_params
    params.permit(:id)
  end 

  def upload_params
    params.require(:tariffication).permit(:school_data)
  end  

  def prepare_data
    subjects  = Subject.select(:name).distinct.map{|sn| [sn.name, sn.name]}
    [subjects]
  end  

end
