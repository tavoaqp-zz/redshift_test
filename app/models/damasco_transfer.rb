##
# Classe que representa uma transferência tipo D

class DamascoTransfer < Transfer

	def calculate_tax
		DamascoTaxCalculator.new.calculate_tax(self)
	end

end