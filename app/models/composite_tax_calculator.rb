class CompositeTaxCalculator < TaxCalculator

	def calculate_tax(transfer)
		@children.each do |child|
			child.calculate_tax(transfer)
		end
	end

end