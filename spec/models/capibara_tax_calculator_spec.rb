require 'spec_helper'
require 'devise/test_helpers'

describe CapibaraTaxCalculator do

	describe "create a transfer and check if calculator is called" do

		let(:user) { FactoryGirl.build(:user, :id => 2) }

	    let(:account1) { FactoryGirl.build(:account, :user => user, :code => "12345-5") }

	    let(:account2) { FactoryGirl.build(:account, :user => user, :code => "12366-5") }

	    subject { FactoryGirl.build(:capibara_transfer, :user => user, :source_account => account1, :destination_account => account2, :amount => 100, :scheduled_date => (Date.today+1.day), :created_at => Date.today ) }

	    let(:tax_calculator) { CapibaraTaxCalculator.new } 

		it "should update tax accordingly when days to schedule is below 5" do		
		
			subject.scheduled_date=Date.today+1.days	
			subject.stub(:save)
			tax_calculator.calculate_tax(subject)

			subject.tax.should == subject.amount * CapibaraTaxCalculator::CAPIBARA_TAX_BASE_LESS_THAN_5

		end

		it "should update tax accordingly when days to schedule are between 5 and 10" do		
		
			subject.scheduled_date=Date.today+6.days	
			subject.stub(:save)
			tax_calculator.calculate_tax(subject)

			subject.tax.should == subject.amount * CapibaraTaxCalculator::CAPIBARA_TAX_BASE_BETWEEN_5_AND_10

		end

		it "should update tax accordingly when days to schedule are between 10 and 15" do		
		
			subject.scheduled_date=Date.today+11.days	
			subject.stub(:save)
			tax_calculator.calculate_tax(subject)

			subject.tax.should == subject.amount * CapibaraTaxCalculator::CAPIBARA_TAX_BASE_BETWEEN_10_AND_15

		end

		it "should update tax accordingly when days to schedule are between 15 and 20" do		
		
			subject.scheduled_date=Date.today+16.days	
			subject.stub(:save)
			tax_calculator.calculate_tax(subject)

			subject.tax.should == subject.amount * CapibaraTaxCalculator::CAPIBARA_TAX_BASE_BETWEEN_15_AND_20

		end

		it "should update tax accordingly when days to schedule are between 20 and 25" do		
		
			subject.scheduled_date=Date.today+21.days	
			subject.stub(:save)
			tax_calculator.calculate_tax(subject)

			subject.tax.should == subject.amount * CapibaraTaxCalculator::CAPIBARA_TAX_BASE_BETWEEN_20_AND_25

		end

		it "should update tax accordingly when days to schedule are between 25 and 30" do		
		
			subject.scheduled_date=Date.today+26.days	
			subject.stub(:save)
			tax_calculator.calculate_tax(subject)

			subject.tax.should == subject.amount * CapibaraTaxCalculator::CAPIBARA_TAX_BASE_BETWEEN_25_AND_30

		end

		it "should update tax accordingly when days to schedule is above 30" do		
		
			subject.scheduled_date=Date.today+31.days	
			subject.stub(:save)
			tax_calculator.calculate_tax(subject)

			subject.tax.should == subject.amount * CapibaraTaxCalculator::CAPIBARA_TAX_BASE_GREATER_THAN_30

		end
		
	end

end