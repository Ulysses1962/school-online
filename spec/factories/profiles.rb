FactoryGirl.define do 
  sequence(:m_fname) do |n|
    first_names = %w[Іван Петро Олексій Василь Дмитро Станіслав Микола]
    "#{first_names[n % first_names.length]}"
  end   

  sequence(:m_lname) do |n|
    last_names = %w[Ротанов Стремецький Василишин Богданов Грановський Іванов Петров]
    "#{last_names[n % last_names.length]}"
  end   
  
  sequence(:f_fname) do |n|
    first_names = %w[Аліна Ольга Олена Тамара Ірина Вікторія Валерія]
    "#{first_names[n % first_names.length]}"
  end   
  
  sequence(:f_lname) do |n|
    last_names = %w[Іванова Петрова Ротанова Стремецька Василишина Богданова Грановська]
    "#{last_names[n % last_names.length]}"
  end   
  
  sequence(:b_date) {|n| "#{(20 + n).years.ago}"}

  factory :male_profile, class: Profile do
    transient do  
      f_name nil
      l_name nil
      b_date nil
    end

    first_name  {if f_name.nil? then generate(:m_fname) else f_name end} 
    last_name   {if l_name.nil? then generate(:m_lname) else l_name end}
    birth_date  {if b_date.nil? then generate(:b_date) else b_date end}

    after :build do |profile|
      profile.phones << FactoryGirl.build(:phone)
      profile.address = FactoryGirl.build(:address)
    end

    trait :teacher do
      after :build do |profile|
        profile.tax_code = FactoryGirl.build(:tax_code)
      end  
    end  

    trait :parent do
      after :build do
        3.times profile.personal_files << FactoryGirl.build(:personal_file)
      end  
    end   
  end

  factory :female_profile, class: Profile do
    transient do  
      f_name nil
      l_name nil
      b_date nil
    end

    first_name  {if f_name.nil? then generate(:f_fname) else f_name end} 
    last_name   {if l_name.nil? then generate(:f_lname) else l_name end}
    birth_date  {if b_date.nil? then generate(:b_date) else b_date end}

    after :build do |profile|
      profile.phones << FactoryGirl.build(:phone)
      profile.address = FactoryGirl.build(:address)
    end

    trait :teacher do
      after :build do |profile|
        profile.tax_code = FactoryGirl.build(:tax_code)
      end  
    end 

    trait :parent do
      after :build do
        3.times profile.personal_files << FactoryGirl.build(:personal_file)
      end  
    end   
  end
end