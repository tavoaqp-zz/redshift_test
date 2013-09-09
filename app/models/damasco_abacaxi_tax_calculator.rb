##
# Classe que calcula taxa para transferências tipo D mas que chama a logica do calculo para transferências tipo A

class DamascoAbacaxiTaxCalculator < AbacaxiTaxCalculator

	def calculate_tax(transfer)
		if (transfer.amount <= 25000)
			super(transfer)
		end
	end
end