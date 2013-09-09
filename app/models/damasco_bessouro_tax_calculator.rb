class DamascoBessouroTaxCalculator < BessouroTaxCalculator

	def calculate_tax(transfer)
		if (transfer.amount >= 25001 && transfer.amount <= 120000)
			super(transfer)
		end
	end

end