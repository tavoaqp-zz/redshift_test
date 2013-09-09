##
# Classe que calcula taxa para transferencias tipo B

class BessouroTaxCalculator < TaxCalculator

	def calculate_tax(transfer)
		if (transfer.days_to_schedule <= 30 )
			transfer.tax=10
		else
			transfer.tax=8
		end
		transfer.save
	end

end