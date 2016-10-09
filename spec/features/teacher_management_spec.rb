require 'rails_helper'

RSpec.feature "Subject administration", type: :feature do 
  before(:all) do
    DatabaseCleaner.clean
    FactoryGirl.create :user, :with_admin_role, user_name: 'Ulysses', user_password: 'qwerasdf'
    # Preparing database testing records, creating teachers
    10.times do 
      u = FactoryGirl.build :user. :with_teacher_role
      u.save
    end   
    # Preparing database testing records, creating subjects
    10.times do
      s = FactoryGirl.build :subject
      s.save
    end  
  end 

  before(:each) do 
    # Login as admin
    visit new_user_session_path()
    fill_in "user_sign_token", with: 'Ulysses'
    fill_in "user_password", with: 'qwerasdf'
    click_button "Увійти!"
    # Go to the teachers index    
    visit admin_teachers_path()
  end  

  scenario "Teachers list" do
    expect(Teacher.count).to eq(10)
    10.times do |i|
      teacher = Teacher.offset(i).first
      within "table tbody tr:nth-child(#{i + 1})" do
        expect(page).to have_content teacher.id
        expect(page).to have_content teacher.profile.first_name
        expect(page).to have_content teacher.profile.last_name
      end  
    end
  end 

  scenario "Teacher editing" do
    # Changing data in row 1
    within "table tbody tr:nth-child(1)" do
      click_link "Змінити"
    end  
    # Got to the teacher editing form
    fill_in "teacher_first_name", with: 'Богдан'
    fill_in "teacher_last_name", with: 'Іванишин'
    click_button 'Зберегти'
    # Check data validity row 1
    within "table tbody tr:nth-child(1)" do
      expect(page).to have_content 'Богдан'
      expect(page).to have_content 'Іванишин'
    end  
  end    
  
  scenario "Adding new teacher" do
    # Get to the new teacher form
    click_button "Додати вчителя"
    
    # Creating new instance
    new_teacher = FactoryGirl.build :user, :with_teacher_role
    
    # Fill in form
    fill_in "teacher_school_id", with: new_teacher.school_id
    fill_in "teacher_email", with: new_teacher.email
    fill_in "teacher_username", with: new_teacher.username
    fill_in "teacher_password", with: new_teacher.password
    fill_in "teacher_password_confirmation", with: new_teacher.password_confirmation
    
    # Fiil in subjects info
    select 'subject_1', from: 'teacher_subjects_attributes_0_id'
    select 'subject_2', from: 'teacher_subjects_attributes_1_id'
    select 'subject_3', from: 'teacher_subjects_attributes_2_id'
     
    # Fill in profile info    
    fill_in 'teacher_profile_attributes_first_name', with: new_teacher.profile.first_name
    fill_in 'teacher_profile_attributes_last_name', with: new_teacher.profile.last_name
    fill_in 'teacher_profile_attributes_birth_date', with: new_teacher.profile.birth_date
    fill_in 'teacher_profile_attributes_address_attributes_address_string', with: new_teacher.profile.address.address_string
    
    
    





    click_button "Зберегти"
    # Check data validity row 3
    within "table tbody tr:nth-child(3)" do
      expect(page).to have_content 'Астрономія'
      expect(page).to have_content 10
    end  
  end  


  after(:all) do 
    DatabaseCleaner.clean
  end   
end  