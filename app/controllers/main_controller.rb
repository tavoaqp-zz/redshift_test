class MainController < ApplicationController

  def index
  	if (current_user)
  		@accounts=current_user.accounts
  		render action: 'index', controller: 'account'
  	end
  end
  
end
