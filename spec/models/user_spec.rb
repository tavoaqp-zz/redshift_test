require 'spec_helper'
require 'devise/test_helpers'

describe User do
	context 'Associations' do
	    it { should have_many(:transfers).dependent(:destroy) }
	    it { should have_many(:accounts).dependent(:destroy) }
  	end
end
