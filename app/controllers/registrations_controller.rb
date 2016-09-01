class RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, :excepr => [:new]
  load_and_authorize_resource :except => [:new]

  attr_accessor :can_modify_password

  def new
    super
  end 

  def create 
    super  
  end 

  def edit 
    super
  end 

  def destroy
    super
  end 

  def update
    new_params = update_params
    
    @user = User.find(current_user.id)
    update_ok =
      if @can_modify_password
        @user.update_with_password(new_params)
      else
        @user.update_without_password(new_params)
      end

    render 'edit' unless update_ok
    
    set_flash_message :notice, "Дані успішно змінено"
    sign_in @user, :bypass => true
    redirect_to after_update_path_for(@user)     
  end

  private

  def update_params
    @can_modify_password = true
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
      params.require(:user).permit(:email, :username)
      @can_modify_password = false
    else
      params.require(:user).permit(:email,
      :username, :current_password, :password, :password_confirmation)
    end        
  end
end
