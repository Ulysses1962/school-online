FactoryGirl.define do
  sequence(:usr_name) {|n| "User_#{n}"}
  sequence(:usr_school_id) {|n| "#{n}"}

  factory :user do
    transient do
      user_name nil
      user_password nil
    end 

    username              {"#{if user_name.nil? then generate(:usr_name) else user_name end}"}
    email                 {"#{username}@intellect.industries"} 
    school_id             {"#{if School.all.empty? then generate(:usr_school_id) else School.first.id end}"}
    password              {"#{if user_password.nil? then User.get_password else user_password end}"}
    password_confirmation {"#{password}"}

    trait :with_teacher_role do
      transient do
        user_gender 'F'
      end

      type "Teacher"

      after :build do |user, evaluator|
        user.roles << Role.find_by(rolename: 'teacher')
        user.profile = if evaluator.user_gender == 'F' then  FactoryGirl.build(:female_profile, :teacher) else FactoryGirl.build(:male_profile, :teacher) end 
        3.times user.subjects << FactoryGirl.build(:subject)
      end  
    end  

    trait :with_student_role do
      type "Student"
      after :build do |user|
        user.roles << Role.find_by(rolename: 'student')
      end  
    end  

    trait :with_admin_role do
      transient do
        gender 'M'
      end  
      
      after :build do |user, evaluator|
        user.roles << Role.find_by(rolename: 'admin')
        user.profile = if evaluator.gender == 'F' then  FactoryGirl.build(:female_profile) else FactoryGirl.build(:male_profile) end 
      end   
    end  
  end  
end
