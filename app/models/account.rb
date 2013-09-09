# encoding: utf-8
class Account < ActiveRecord::Base
	belongs_to :user

	validates_format_of :code, :with => /\A\d{5,5}\-\d{1,1}\z/, :message => "O codigo da conta precisa ser no formato XXXXX-X"
	validates_uniqueness_of :code
end
