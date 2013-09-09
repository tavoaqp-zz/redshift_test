class BessouroTransfer < Transfer

	def calculate_tax
		if (days_to_schedule <= 30 )
			tax=10
		else
			tax=8
		end
		save!
	end
end