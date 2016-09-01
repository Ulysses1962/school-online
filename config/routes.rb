Rails.application.routes.draw do
  namespace :admin do
    get 'tariffications/index'
  end

  root to: 'home#index'
  devise_for :users, :controllers => { registrations: 'registrations' }

  namespace :admin do
    get 'welcome', to: 'welcome#index' 

    resources :teachers
    get 'update_subjects', to: 'teachers#update_subjects'
    get 'update_roles', to: 'teachers#update_roles'  
    post 'import_teachers', to: 'teachers#import_teachers'

    resources :subjects
    post 'import_subjects', to: 'subjects#import_subjects'

    resources :schools
    post 'import_school', to: 'schools#import_school'

    resources :parents
    resources :students
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
