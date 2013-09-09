require 'spec_helper'
require 'devise/test_helpers'

describe DamascoTaxCalculator do

	let(:damasco_tax_calculator) { DamascoTaxCalculator.new }

	describe "create children at initialization" do

		it "checks if children are the correct type" do
			damasco_tax_calculator.child(0).should be_an_instance_of DamascoAbacaxiTaxCalculator
			damasco_tax_calculator.child(1).should be_an_instance_of DamascoCapibaraTaxCalculator
			damasco_tax_calculator.child(2).should be_an_instance_of DamascoBessouroTaxCalculator			
		end

	end

	describe "check tax rules" do

		let(:user) { FactoryGirl.build(:user, :id => 2) }

	    let(:account1) { FactoryGirl.build(:account, :user => user, :code => "12345-5") }

    	let(:account2) { FactoryGirl.build(:account, :user => user, :code => "12366-5") }

    	let(:abacaxi_transfer) { FactoryGirl.build(:abacaxi_transfer, :user => user, :source_account => account1, :destination_account => account2, :amount => 100, :scheduled_date => (Date.today+1.day), :created_at => Date.today ) }

    	let(:same_amount_abacaxi_transfer) { FactoryGirl.build(:abacaxi_transfer, :user => user, :source_account => account1, :destination_account => account2, :amount => 100, :scheduled_date => (Date.today+1.day), :created_at => Date.today ) }

    	let(:bessouro_transfer) { FactoryGirl.build(:abacaxi_transfer, :user => user, :source_account => account1, :destination_account => account2, :amount => 25001, :scheduled_date => (Date.today+1.day), :created_at => Date.today ) }

    	let(:same_amount_bessouro_transfer) { FactoryGirl.build(:abacaxi_transfer, :user => user, :source_account => account1, :destination_account => account2, :amount => 25001, :scheduled_date => (Date.today+1.day), :created_at => Date.today ) }

    	let(:capibara_transfer) { FactoryGirl.build(:abacaxi_transfer, :user => user, :source_account => account1, :destination_account => account2, :amount => 120001, :scheduled_date => (Date.today+1.day), :created_at => Date.today ) }

    	let(:same_amount_capibara_transfer) { FactoryGirl.build(:abacaxi_transfer, :user => user, :source_account => account1, :destination_account => account2, :amount => 120001, :scheduled_date => (Date.today+1.day), :created_at => Date.today ) }    	

    	let(:damasco_capibara_tax_calculator) { DamascoCapibaraTaxCalculator.new }    	

    	let(:damasco_besouro_tax_calculator) { DamascoBessouroTaxCalculator.new }	    

	    let(:damasco_abacaxi_tax_calculator) { DamascoAbacaxiTaxCalculator.new }

		it "behaves as DamascoAbacaxiTaxCalculator if amount is below 25000" do
			abacaxi_transfer.stub(:save)	
			damasco_tax_calculator.calculate_tax(abacaxi_transfer)

			same_amount_abacaxi_transfer.stub(:save)
			damasco_abacaxi_tax_calculator.calculate_tax(same_amount_abacaxi_transfer)		

			abacaxi_transfer.tax.should == same_amount_abacaxi_transfer.tax
		end

		it "behaves as DamascoBessouroTaxCalculator if amount is between 25001 and 120000" do
			bessouro_transfer.stub(:save)	
			damasco_tax_calculator.calculate_tax(bessouro_transfer)

			same_amount_bessouro_transfer.stub(:save)
			damasco_besouro_tax_calculator.calculate_tax(same_amount_bessouro_transfer)		

			bessouro_transfer.tax.should == same_amount_bessouro_transfer.tax
		end

		it "behaves as DamascoCapibaraTaxCalculator if amount is above 120000" do
			capibara_transfer.stub(:save)	
			damasco_tax_calculator.calculate_tax(capibara_transfer)

			same_amount_capibara_transfer.stub(:save)
			damasco_capibara_tax_calculator.calculate_tax(same_amount_capibara_transfer)		

			capibara_transfer.tax.should == same_amount_capibara_transfer.tax
		end
	end



end