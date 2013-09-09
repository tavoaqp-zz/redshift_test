require 'spec_helper'
require 'devise/test_helpers'

describe DamascoBessouroTaxCalculator do

	describe "create a transfer and check if calculator is called" do

	let(:user) { FactoryGirl.build(:user, :id => 2) }

    let(:account1) { FactoryGirl.build(:account, :user => user, :code => "12345-5") }

    let(:account2) { FactoryGirl.build(:account, :user => user, :code => "12366-5") }

    subject { FactoryGirl.build(:bessouro_transfer, :user => user, :source_account => account1, :destination_account => account2, :amount => 26000, :scheduled_date => (Date.today+1.day), :created_at => Date.today ) }

    let(:same_amount_transfer) { FactoryGirl.build(:bessouro_transfer, :user => user, :source_account => account1, :destination_account => account2, :amount => 26000, :scheduled_date => (Date.today+1.day), :created_at => Date.today ) }

    let(:bessouro_tax_calculator) { BessouroTaxCalculator.new }

    let(:damasco_besouro_tax_calculator) { DamascoBessouroTaxCalculator.new }

	it "should update tax accordingly" do		

		subject.stub(:save)	
		damasco_besouro_tax_calculator.calculate_tax(subject)

		same_amount_transfer.stub(:save)
		bessouro_tax_calculator.calculate_tax(same_amount_transfer)		

		subject.tax.should == same_amount_transfer.tax

	end
		
	end

end