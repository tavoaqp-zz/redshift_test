class AccountController < ApplicationController
	before_filter :authenticate_user! 

	def index
		@accounts=current_user.accounts
	end

	def show
		@account=Account.find_by_id(params.require(:id))
	end

	def create
		@account=Account.create(params.require(:account).permit(:code, :total))
		@account.user=current_user
		if (!@account.save)
			notice=@account.errors
		end
	end

	def delete
		@account=Account.find_by_id(params.require(:id))
		@account.delete
	end
end
