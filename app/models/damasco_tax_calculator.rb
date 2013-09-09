class DamascoTaxCalculator < CompositeTaxCalculator

	def initialize
		super
		add_child(DamascoAbacaxiTaxCalculator.new)
		add_child(DamascoCapibaraTaxCalculator.new)
		add_child(DamascoBessouroTaxCalculator.new)
	end

end