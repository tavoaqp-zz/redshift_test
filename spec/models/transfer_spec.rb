require 'spec_helper'
require 'devise/test_helpers'

describe Transfer do
	context 'Associations' do
	    it { should belong_to(:source_account).class_name("Account") }
	    it { should belong_to(:destination_account).class_name("Account") }
	    it { should belong_to(:user).class_name("User") }
  	end

  	context 'Validations' do
	    let(:user) { FactoryGirl.build(:user, :id => 2) }
	    let(:account1) { FactoryGirl.build(:account, :user => user, :code => "12345-5") }
	    let(:account2) { FactoryGirl.build(:account, :user => user, :code => "12366-5") }
	    subject { FactoryGirl.build(:transfer, :user => user, :source_account => account1, :destination_account => account2, :amount => 100, :scheduled_date => (Date.today+1.day), :created_at => Date.today ) }

	    it { should validate_presence_of(:src_account_id) }
	    it { should validate_presence_of(:dst_account_id) }

  	end
end

