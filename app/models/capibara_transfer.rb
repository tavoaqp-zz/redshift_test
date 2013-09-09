class CapibaraTransfer < Transfer

	def calculate_tax

		if (days_to_schedule > 30)
			tax = amount * 0.012
		elsif (days_to_schedule > 25 && days_to_schedule <= 30)
			tax = amount * 0.021
		elsif (days_to_schedule > 20 && days_to_schedule <= 25)
			tax = amount * 0.043
		elsif (days_to_schedule > 15 && days_to_schedule <= 20)
			tax = amount * 0.054
		elsif (days_to_schedule > 10 && days_to_schedule <= 15)
			tax = amount * 0.067
		elsif (days_to_schedule > 5 && days_to_schedule <= 10)
			tax = amount * 0.074
		elsif (days_to_schedule <= 5)
			tax = amount * 0.083
		end
				
	end

end