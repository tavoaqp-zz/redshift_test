class AbacaxiTaxCalculator < TaxCalculator

	ABACAXI_BASE_TAX=2.0
	ABACAXI_APPLIED_TAX=0.03

	def calculate_tax(transfer)
		transfer.tax = ABACAXI_BASE_TAX + transfer.amount * ABACAXI_APPLIED_TAX
		transfer.save
	end

end