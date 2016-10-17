Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :marks
  resources :thematic_plans

  namespace :admin do
    get 'welcome', to: 'welcome#index' 
    
    # Teacher related section
    resources :teachers
    post 'import_teachers', to: 'teachers#import_teachers'

    # Tariffications related section
    resources :tariffications
    post 'import_tariffications', to: 'tariffications#import_tariffications'

    # Subject related section
    resources :subjects
    post 'import_subjects', to: 'subjects#import_subjects'

    # Schools related section
    resources :schools
    post 'import_school', to: 'schools#import_school'

    # Student related section
    resources :students
    post 'import_students', to: 'students#import_students'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
