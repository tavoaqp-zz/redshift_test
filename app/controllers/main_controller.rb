##
# Controller principal

class MainController < ApplicationController

  ##
  # Quando usuário entra na home mostra as contas dele se estiver logado. Caso contrario mostra a view de bem-vindas
  def index
  	if (current_user)
  		@accounts=current_user.accounts
  		render action: 'index', controller: 'account'
  	end
  end
  
end
