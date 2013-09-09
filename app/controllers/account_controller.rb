class AccountController < ApplicationController
	before_filter :authenticate_user! 

	def index
		@accounts=current_user.accounts
	end

	def show
		@account=Account.find_by_id(params.require(:id))
	end

	def new
		@account=Account.new
	end

	def create
		@account=Account.create(params.require(:account).permit(:code, :total))
		@account.user=current_user
    	respond_to do |format|
			if (@account.save)
				format.html { render action: 'index', notice: t('account.successfully_created') }
			else
				format.html { render action: 'new' }
			end
		end
	end

	def delete
		@account=Account.find_by_id(params.require(:id))
		@account.delete
	end
end
