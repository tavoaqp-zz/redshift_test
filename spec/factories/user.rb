FactoryGirl.define do 
	factory :user do
		first_name "Joao"
	    last_name "da Silva"
	    email { "teste#{(Time.now.to_f * 1000.0).to_i}#{rand(1000).to_s}@#email.com" }
	    password "senhasecreta"
	end
end
