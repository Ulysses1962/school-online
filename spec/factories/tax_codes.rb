FactoryGirl.define do 
  sequence(:code) { (0..9).to_a.shuffle.join }

  factory :tax_code do
    transient do
      personal_code nil
    end   

    ptc {if personal_code.nil? then generate(:code) else personal_code end}
  end  
end   