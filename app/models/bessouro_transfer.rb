class BessouroTransfer < Transfer

	def calculate_tax
		BessouroTaxCalculator.new.calculate_tax(self)
	end
end