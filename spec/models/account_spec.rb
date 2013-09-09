require 'spec_helper'
require 'devise/test_helpers'

describe Account do
	context 'Associations' do
	    it { should belong_to(:user) }
  	end

  	context 'Validations' do
	    let(:user) { FactoryGirl.build(:user, :id => 2) }
	    subject { FactoryGirl.build(:account, :user => user, :code => "12345-5") }

	    it { should validate_uniqueness_of(:code) }

	    it "should validate code's format" do
	      subject.code="1234-5"
	      subject.user=user
	      subject.valid?

	      subject.errors.messages[:code].first.should == "O codigo da conta precisa ser no formato XXXXX-X"
	    end
  	end
end
