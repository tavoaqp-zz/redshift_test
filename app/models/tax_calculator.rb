class TaxCalculator

	attr :children

	def initialize
		@children=[]
	end

	def add_child(tax_calculator)
		@children<<tax_calculator
	end

	def child(index)
		return @children[index]
	end

	def calculate_tax(transfer)
		
	end

end