require 'spec_helper'

describe TransferController do
	before(:all) do
		Account.delete_all
		Transfer.delete_all
	end

	let(:user) { FactoryGirl.create(:user) }

	let(:account1) { FactoryGirl.create(:account, :user => user, :code => "12345-5") }

	let(:account2) { FactoryGirl.create(:account, :user => user, :code => "12366-5") }

	before do			
  		user.transfers<<FactoryGirl.create(:transfer, :source_account => account1, :destination_account => account2, :amount => 100, :scheduled_date => (Date.today+1.day), :created_at => Date.today )  			
  	end 		

	describe "GET index " do  		

    	it "should show normal index template when user is not logged in " do
    		get 'index'
      		response.should_not be_success
    	end

    	it "should show transfers page when user is logged in" do
    		sign_in user
    		get 'index'
    		assigns(:transfers).should == user.transfers
      		response.should be_success
      		response.should render_template("transfer/index")
    	end
	end

	describe "POST create" do
		it "should create a new transfer object" do
			sign_in user
			transfer_attributes=FactoryGirl.attributes_for(:capibara_transfer, :src_account_id => account1.code, :dst_account_id => account2.code, :amount => 100, :scheduled_date => Date.today+20.days)			

			post :create, :transfer => transfer_attributes
			user.transfers.reload
			user.transfers.should include(assigns(:transfer))
		end

		it "should create a new capibara transfer object" do
			sign_in user
			transfer_attributes=FactoryGirl.attributes_for(:capibara_transfer, :src_account_id => account1.code, :dst_account_id => account2.code, :amount => 100, :scheduled_date => Date.today+20.days)			

			post :create, :capibara_transfer => transfer_attributes
			user.transfers.reload
			user.transfers.should include(assigns(:transfer))
		end

		it "should create a new bessouro transfer object" do
			sign_in user
			transfer_attributes=FactoryGirl.attributes_for(:capibara_transfer, :src_account_id => account1.code, :dst_account_id => account2.code, :amount => 100, :scheduled_date => Date.today+20.days)			

			post :create, :bessouro_transfer => transfer_attributes
			user.transfers.reload
			user.transfers.should include(assigns(:transfer))
		end

		it "should create a new abacaxi transfer object" do
			sign_in user
			transfer_attributes=FactoryGirl.attributes_for(:capibara_transfer, :src_account_id => account1.code, :dst_account_id => account2.code, :amount => 100, :scheduled_date => Date.today+20.days)			

			post :create, :abacaxi_transfer => transfer_attributes
			user.transfers.reload
			user.transfers.should include(assigns(:transfer))
		end

		it "should create a new damasco transfer object" do
			sign_in user
			transfer_attributes=FactoryGirl.attributes_for(:capibara_transfer, :src_account_id => account1.code, :dst_account_id => account2.code, :amount => 100, :scheduled_date => Date.today+20.days)			

			post :create, :damasco_transfer => transfer_attributes
			user.transfers.reload
			user.transfers.should include(assigns(:transfer))
		end
	end

	describe "GET show" do
		it "should render show template" do
			sign_in user
			user.transfers.reload
			get :show, :id => user.transfers.first.id
			assigns(:transfer).should == user.transfers.first
		end
	end

	describe "DELETE delete" do
		it "should delete a transfer" do
			sign_in user
			user.transfers.reload
			delete :delete, :id => user.transfers.first.id
			user.transfers.reload
			user.transfers.should_not include(assigns(:transfer))
		end
	end

end
