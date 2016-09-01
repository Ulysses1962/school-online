FactoryGirl.define do
  sequence(:subj_name) {|n| "subject_#{n}"}
  sequence(:subj_year) {|n| "#{n}"}

  factory :subject do 
    transient do
      s_name nil
      s_year nil
    end

    name   {"#{if name.nil? then generate(:subj_name) else s_name end}"}
    level  {"#{if year.nil? then generate(:subj_year) else s_year end}"}
  end  
end  