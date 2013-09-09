class CapibaraTaxCalculator < TaxCalculator

	CAPIBARA_TAX_BASE_GREATER_THAN_30 = 0.012
	CAPIBARA_TAX_BASE_BETWEEN_25_AND_30 = 0.021
	CAPIBARA_TAX_BASE_BETWEEN_20_AND_25 = 0.043
	CAPIBARA_TAX_BASE_BETWEEN_15_AND_20 = 0.054
	CAPIBARA_TAX_BASE_BETWEEN_10_AND_15 = 0.067
	CAPIBARA_TAX_BASE_BETWEEN_5_AND_10 = 0.074
	CAPIBARA_TAX_BASE_LESS_THAN_5 = 0.083

	def calculate_tax(transfer)
		if ( more_than_30_days?(transfer) )
			transfer.tax = transfer.amount * CAPIBARA_TAX_BASE_GREATER_THAN_30
		elsif ( between_25_and_30_days?(transfer) )
			transfer.tax = transfer.amount * CAPIBARA_TAX_BASE_BETWEEN_25_AND_30
		elsif ( between_20_and_25_days?(transfer) )
			transfer.tax = transfer.amount * CAPIBARA_TAX_BASE_BETWEEN_20_AND_25
		elsif ( between_15_and_20_days(transfer) )
			transfer.tax = transfer.amount * CAPIBARA_TAX_BASE_BETWEEN_15_AND_20
		elsif ( between_10_and_15_days(transfer) )
			transfer.tax = transfer.amount * CAPIBARA_TAX_BASE_BETWEEN_10_AND_15
		elsif ( between_5_and_10_days(transfer) )
			transfer.tax = transfer.amount * CAPIBARA_TAX_BASE_BETWEEN_5_AND_10
		elsif ( less_than_5_days(transfer) )
			transfer.tax = transfer.amount * CAPIBARA_TAX_BASE_LESS_THAN_5
		end
		transfer.save
	end

	def more_than_30_days?(transfer)
		transfer.days_to_schedule > 30
	end

	def between_25_and_30_days?(transfer)
		transfer.days_to_schedule > 25 && transfer.days_to_schedule <= 30
	end

	def between_20_and_25_days?(transfer)
		transfer.days_to_schedule > 20 && transfer.days_to_schedule <= 25
	end

	def between_15_and_20_days(transfer)
		transfer.days_to_schedule > 15 && transfer.days_to_schedule <= 20
	end

	def between_10_and_15_days(transfer)
		transfer.days_to_schedule > 10 && transfer.days_to_schedule <= 15
	end

	def between_5_and_10_days(transfer)
		transfer.days_to_schedule > 5 && transfer.days_to_schedule <= 10
	end

	def less_than_5_days(transfer)
		transfer.days_to_schedule <= 5
	end

end