class CapibaraTransfer < Transfer

	def calculate_tax
		CapibaraTaxCalculator.new.calculate_tax(self)
	end

end