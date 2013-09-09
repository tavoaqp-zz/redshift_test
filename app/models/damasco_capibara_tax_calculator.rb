class DamascoCapibaraTaxCalculator < CapibaraTaxCalculator

	def calculate_tax(transfer)
		if (transfer.amount > 120000)
			super(transfer)
		end
	end

end