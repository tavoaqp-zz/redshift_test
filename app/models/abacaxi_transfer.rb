class AbacaxiTransfer < Transfer

	ABACAXI_BASE_TAX=2.0

	def calculate_tax
		tax=ABACAXI_BASE_TAX+amount * 0.03
		save!
	end

end