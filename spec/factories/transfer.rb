FactoryGirl.define do 
	factory :transfer do
	end

	factory :damasco_transfer do
		type "DamascoTransfer"
	end

	factory :abacaxi_transfer do
		type "AbacaxiTransfer"
	end

	factory :capibara_transfer do
		type "CapibaraTransfer"
	end

	factory :bessouro_transfer do
		type "BessouroTransfer"
	end
end
