require 'spec_helper'
require 'devise/test_helpers'

describe BessouroTaxCalculator do

	describe "create a transfer and check if calculator is called" do

	let(:user) { FactoryGirl.build(:user, :id => 2) }

    let(:account1) { FactoryGirl.build(:account, :user => user, :code => "12345-5") }

    let(:account2) { FactoryGirl.build(:account, :user => user, :code => "12366-5") }

    subject { FactoryGirl.build(:bessouro_transfer, :user => user, :source_account => account1, :destination_account => account2, :amount => 100, :scheduled_date => (Date.today+1.day), :created_at => Date.today ) }

    let(:tax_calculator) { BessouroTaxCalculator.new } 

	it "should update tax accordingly when days to schedule is below 30" do		
	
		subject.scheduled_date=Date.today+25.days	
		subject.stub(:save)
		tax_calculator.calculate_tax(subject)

		subject.tax.should == 10

	end

	it "should update tax accordingly when days to schedule is above 30" do		

		subject.scheduled_date=Date.today+32.days	
		subject.stub(:save)
		tax_calculator.calculate_tax(subject)

		subject.tax.should == 8

	end
		
	end

end