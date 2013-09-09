##
# Classe que calcula taxa para transferências tipo D e que, de acordo com o valor da transferencia, chama 
# um dos algoritmos de calculo de taxa para os tipos A,B e C

class DamascoTaxCalculator < CompositeTaxCalculator

	def initialize
		super
		add_child(DamascoAbacaxiTaxCalculator.new)
		add_child(DamascoCapibaraTaxCalculator.new)
		add_child(DamascoBessouroTaxCalculator.new)
	end

end