class MainController < ApplicationController

  def index
  	if (current_user)
  		@accounts=current_user.accounts
  		render "account/index"
  	end
  end
  
end
