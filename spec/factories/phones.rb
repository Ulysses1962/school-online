FactoryGirl.define do 
  sequence(:provider) do |n|
    prov_codes = %w[050 066 067 097 063]
    "(#{prov_codes[n % prov_codes.length]})"
  end
  sequence(:number) do |n| 
    a = (n % 6..9).to_a.combination(3).to_a
    b = (n % 7..9).to_a.combination(2).to_a

    "#{a[n % a.length].join}-#{b[n % b.length].join}-#{b[(n + 1) % b.length].join}"
  end  
  
  factory :phone do
    transient do
      p_num nil
    end

    phone_num {if p_num.nil? then "#{generate(:provider)}#{generate(:number)}" else p_num end}  
  end     
end  