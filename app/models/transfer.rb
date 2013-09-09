class Transfer < ActiveRecord::Base
	belongs_to :source_account, :foreign_key => "src_account_id", :primary_key => "code", :class_name => "Account"
	belongs_to :destination_account, :foreign_key => "dst_account_id", :primary_key => "code", :class_name => "Account"
	belongs_to :user

	validates_presence_of :src_account_id
	validates_presence_of :dst_account_id
	validates_presence_of :amount
	validates_presence_of :scheduled_date
	validates_format_of :src_account_id, :with => /\A\d{5,5}\-\d{1,1}\z/, :message => "O codigo da conta precisa ser no formato XXXXX-X"
	validates_format_of :dst_account_id, :with => /\A\d{5,5}\-\d{1,1}\z/, :message => "O codigo da conta precisa ser no formato XXXXX-X"

	validates_numericality_of :amount, :greater_than => 0
	validate :date_range

	after_create :calculate_tax

	#Corpo vazio a ser escrito pelas classes filhas
	def calculate_tax
	end

	def date_range
		if ( days_to_schedule < 0 )
			errors.add(:scheduled_date, "A data de agendamento precisa ser maior ou igual ao dia atual")
		end
	end

	def days_to_schedule
		if (!scheduled_date.nil?)
			(scheduled_date - Date.today).to_i
		else
			-1
		end
	end

end
