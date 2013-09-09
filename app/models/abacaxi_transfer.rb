##
# Classe que representa transferencias tipo A

class AbacaxiTransfer < Transfer

	def calculate_tax
		AbacaxiTaxCalculator.new.calculate_tax(self)
	end

end