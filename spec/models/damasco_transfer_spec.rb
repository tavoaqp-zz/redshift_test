require 'spec_helper'
require 'devise/test_helpers'

describe DamascoTransfer do

	describe "create a transfer and check if calculator is called" do

		let(:user) { FactoryGirl.build(:user, :id => 2) }

	    let(:account1) { FactoryGirl.build(:account, :user => user, :code => "12345-5") }

	    let(:account2) { FactoryGirl.build(:account, :user => user, :code => "12366-5") }

	    subject { FactoryGirl.build(:damasco_transfer, :user => user, :source_account => account1, :destination_account => account2, :amount => 100, :scheduled_date => (Date.today+1.day), :created_at => Date.today ) }

		it "should create an instance of DamascoTaxCalculator" do		
			
			damasco_tax_calculator=double(DamascoTaxCalculator)
			DamascoTaxCalculator.should_receive(:new).and_return(damasco_tax_calculator)
			damasco_tax_calculator.should_receive(:calculate_tax).with(subject)		

			subject.calculate_tax

		end
		
	end

end