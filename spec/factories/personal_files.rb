FactoryGirl.define do 
  sequence(:file_code) {|n| "#{('а'..'л').to_a[n % 9]}-#{(1..9).to_a.combination(4).to_a[n % 20].join}"}

  factory :personal_file do
    transient do
      personal_number nil
    end 

    personal_file_code {if personal_number.nil? then generate(:file_code) else personal_number end}  
  end  
end  