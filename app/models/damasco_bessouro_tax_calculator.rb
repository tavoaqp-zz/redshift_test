##
# Classe que calcula taxa para transferências tipo D mas que chama a logica do calculo para transferencias tipo B

class DamascoBessouroTaxCalculator < BessouroTaxCalculator

	def calculate_tax(transfer)
		if (transfer.amount >= 25001 && transfer.amount <= 120000)
			super(transfer)
		end
	end

end