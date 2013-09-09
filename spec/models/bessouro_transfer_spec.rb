require 'spec_helper'
require 'devise/test_helpers'

describe AbacaxiTransfer do

	describe "create a transfer and check if calculator is called" do

		let(:user) { FactoryGirl.build(:user, :id => 2) }

	    let(:account1) { FactoryGirl.build(:account, :user => user, :code => "12345-5") }

	    let(:account2) { FactoryGirl.build(:account, :user => user, :code => "12366-5") }

	    subject { FactoryGirl.build(:bessouro_transfer, :user => user, :source_account => account1, :destination_account => account2, :amount => 100, :scheduled_date => (Date.today+1.day), :created_at => Date.today ) }

		it "should create an instance of BessouroTaxCalculator" do		
			
			bessouro_tax_calculator=double(BessouroTaxCalculator)
			BessouroTaxCalculator.should_receive(:new).and_return(bessouro_tax_calculator)
			bessouro_tax_calculator.should_receive(:calculate_tax).with(subject)		

			subject.calculate_tax

		end
		
	end

end