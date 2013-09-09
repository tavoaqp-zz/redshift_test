require 'spec_helper'

describe MainController do

	let(:user) { FactoryGirl.create(:user) }

	describe "GET index " do

  		before do			
  			user.accounts<<FactoryGirl.build(:account, :code => "12345-1")
  			user.accounts<<FactoryGirl.build(:account, :code => "12346-1")			
  		end

    	it "should show normal index template when user is not logged in " do
    		get 'index'
      		response.should be_success
      		response.should render_template("main/index")
    	end

    	it "should show accounts page when user is logged in" do
    		sign_in user
    		get 'index'
    		assigns(:accounts).should == user.accounts
      		response.should be_success
      		response.should render_template("account/index")
    	end
	end

end
