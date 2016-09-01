require 'rails_helper'

RSpec.feature "Subject administration", type: :feature do 
  before(:all) do
    DatabaseCleaner.clean
    # Creating testing data
    FactoryGirl.create :user, :with_admin_role, user_name: 'Ulysses', user_password: 'qwerasdf'
    FactoryGirl.create :subject, name: 'Історія', year: 6
    FactoryGirl.create :subject, name: 'Фізика', year: 9
  end 

  before(:each) do 
    # Login as admin
    visit new_user_session_path()
    fill_in "user_sign_token", with: 'Ulysses'
    fill_in "user_password", with: 'qwerasdf'
    click_button "Увійти!"
    # Go to the sibject index    
    visit admin_subjects_path()
  end  

  scenario "Subject list" do
    expect(Subject.count).to eq(2)
    2.times do |i|
      subj = Subject.offset(i).first  
      within "table tbody tr:nth-child(#{i + 1})" do
        expect(page).to have_content subj.name
        expect(page).to have_content subj.level
      end
    end     
  end  

  scenario "Subject editing" do
    # Changing data in row 1
    within "table tbody tr:nth-child(1)" do
      click_link "Змінити"
    end  
    # Got to the subject editing form
    fill_in "subject_description", with: 'Природознавство'
    click_button 'Зберегти'
    # Check data validity row 1
    within "table tbody tr:nth-child(1)" do
      expect(page).to have_content 'Природознавство'
      expect(page).to have_content 6
    end  
  end    

  scenario "Adding new subject" do
    # Get to the new subject form
    click_button "Створити курс"
    # Fill in form
    fill_in "subject_description", with: 'Астрономія'
    fill_in "subject_level", with: 10
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