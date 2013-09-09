require 'spec_helper'
require 'devise/test_helpers'

describe AbacaxiTaxCalculator do

	describe "create a transfer and check if calculator is called" do

	let(:user) { FactoryGirl.build(:user, :id => 2) }

    let(:account1) { FactoryGirl.build(:account, :user => user, :code => "12345-5") }

    let(:account2) { FactoryGirl.build(:account, :user => user, :code => "12366-5") }

    subject { FactoryGirl.build(:abacaxi_transfer, :user => user, :source_account => account1, :destination_account => account2, :amount => 100, :scheduled_date => (Date.today+1.day), :created_at => Date.today ) }

	it "should update tax accordingly" do		
		subject.stub(:save)
		abacaxi_tax_calculator=AbacaxiTaxCalculator.new
		abacaxi_tax_calculator.calculate_tax(subject)
		subject.tax.should == (AbacaxiTaxCalculator::ABACAXI_BASE_TAX + subject.amount * AbacaxiTaxCalculator::ABACAXI_APPLIED_TAX)

	end
		
	end

end