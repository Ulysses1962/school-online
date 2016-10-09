require 'data_import'

class Admin::SubjectsController < ApplicationController
  authorize_resource
  
  def index
    @subject  = Subject.new
    @subjects = Subject.all.order('level ASC').paginate(page: index_params[:page], per_page: 15)
  end   

  def new
    @subject = Subject.new
  end 

  def create 
    return redirect_to admin_subjects_path(), alert: "Такий предмет вже існує у базі даних" if Subject.exists?(name: create_params[:name], level: create_params[:level])
    
    @subject = Subject.create(create_params)
    if @subject.save
      redirect_to admin_subjects_path(), notice: "Дані курсу успішно збережені!" and return
    else
      render 'new'
    end
  end  

  def edit
    @subject = Subject.find(edit_params[:id])
  end 

  def update
    @subject = Subject.find(edit_params[:id])
    if @subject.update_attributes(update_params)
      render json: @subject
    else
      render json: @subject.errors, status: :unprocessable_entity
    end    
  end

  def import_subjects
    # Serve uploaded data file
    uploaded_file = upload_params[:school_data]
    File.open(Rails.root.join('data', uploaded_file.original_filename), 'wb') do |file|
      file.write(uploaded_file.read)
    end  

    # Import data
    DataImport::subjects_import(['data/', uploaded_file.original_filename].join)    
    
    # Removing data file
    File.delete(Rails.root.join('data', uploaded_file.original_filename))

    redirect_to admin_subjects_path(), notice: "Дані успішно імпортовано!" and return
  end  

  private
  def index_params
    params.permit(:page)
  end   

  def edit_params
    params.permit(:id)
  end

  def update_params
    params.require(:subject).permit(:id, :_destroy, :name, :level)
  end     

  def create_params
    params.require(:subject).permit(:name, :level)
  end  

  def upload_params
    params.require(:subject).permit(:school_data)
  end  
end
