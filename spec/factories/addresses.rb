FactoryGirl.define do 
  sequence(:street) do |n|
    street_names = %w[Зарічанська Кам'янецька Подільська Проскурівська]
    "#{street_names[n % street_names.length]} #{n % 68}"
  end
  sequence(:apartment, 25)  {|n| n % 40}

  factory :address do
    transient do
      addr_string nil
    end 

    address_string {"Україна, Хмельницький, вул.#{if addr_string.nil? then generate(:street) else addr_string end}, кв.#{generate(:apartment)}"}
  end  
end  