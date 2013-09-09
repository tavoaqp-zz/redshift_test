require 'spec_helper'

describe AccountController do
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

    	it "should show accounts page when user is logged in" do
    		sign_in user
    		get 'index'
    		assigns(:accounts).should == user.accounts
      		response.should be_success
      		response.should render_template("account/index")
    	end
	end

	describe "POST create" do
		it "should create a new account object" do
			sign_in user
			account_attributes=FactoryGirl.attributes_for(:account, :total => 100, :code => "12347-5")			

			post :create, :account => account_attributes
			user.accounts.reload
			user.accounts.should include(assigns(:account))
		end
	end

	describe "GET show" do
		it "should render show template" do
			sign_in user
			user.accounts.reload
			get :show, :id => user.accounts.first.id
			assigns(:account).should == user.accounts.first
		end
	end

	describe "DELETE delete" do
		it "should delete a transfer" do
			sign_in user
			user.accounts.reload
			delete :delete, :id => user.accounts.first.id
			user.accounts.reload
			user.accounts.should_not include(assigns(:account))
		end
	end

end
