class AccountController < ApplicationController
	before_filter :authenticate_user! 

	def index
		@accounts=current_user.accounts
	end

	def show
		@account=Account.find_by_id(params[:id])
	end

	def create
		@account=Account.create(params[:account])
		if (@account.save)
			current_user.accounts<<@account
		else
			notice=@account.errors
		end
	end

	def delete
		@account=Account.find_by_id(params[:id])
		@account.delete
	end
end
