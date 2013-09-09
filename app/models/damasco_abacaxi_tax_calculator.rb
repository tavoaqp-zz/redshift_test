class DamascoAbacaxiTaxCalculator < AbacaxiTaxCalculator

	def calculate_tax(transfer)
		if (transfer.amount <= 25000)
			super(transfer)
		end
	end
end