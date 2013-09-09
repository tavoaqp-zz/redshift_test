##
# Controller de transferências

class TransferController < ApplicationController
  before_filter :authenticate_user! 

  def index
  	@transfers=current_user.transfers
  end

  def show
    @transfer=Transfer.find_by_id(params.require(:id))
  end

  def new
    @transfer=Transfer.new
  end

  ##
  # Este metodo recebe o POST e cria um objeto Transfer. Dependendo do tipo escolhido no formulario um dos quatro tipos de transferência é criado
  # e, respetivamente, um dos TaxCalculator é disparado para calcular a taxa.
  def create 
    
    if (params[:transfer])
      transfer_params(params)      
    elsif (params[:abacaxi_transfer])
      abacaxi_transfer_params(params)      
    elsif (params[:bessouro_transfer])
      bessouro_transfer_params(params)
    elsif (params[:capibara_transfer])
      capibara_transfer_params(params)
    elsif (params[:damasco_transfer])
      damasco_transfer_params(params)
    end    

    @transfer.user=current_user

    respond_to do |format|
      if (@transfer.save)
        format.html { redirect_to action: :index, notice: t('transfer.successfully_created') }
      else
        format.html { render action: 'new' }
      end
    end

  end

  def delete
    @transfer=Transfer.find_by_id(params.require(:id))
    @transfer.delete
  end

  private

  def transfer_params(params)
    params.require(:transfer)
    @transfer=Transfer.new(params[:transfer].permit(:src_account_id, :dst_account_id, :amount, :type, :scheduled_date))
  end

  def abacaxi_transfer_params(params)
    params.require(:abacaxi_transfer)
    @transfer=Transfer.new(params[:abacaxi_transfer].permit(:src_account_id, :dst_account_id, :amount, :type, :scheduled_date))
  end

  def bessouro_transfer_params(params)
    params.require(:bessouro_transfer)
    @transfer=Transfer.new(params[:bessouro_transfer].permit(:src_account_id, :dst_account_id, :amount, :type, :scheduled_date))
  end

  def capibara_transfer_params(params)
    params.require(:capibara_transfer)
    @transfer=Transfer.new(params[:capibara_transfer].permit(:src_account_id, :dst_account_id, :amount, :type, :scheduled_date))
  end

  def damasco_transfer_params(params)
    params.require(:damasco_transfer)
    @transfer=Transfer.new(params[:damasco_transfer].permit(:src_account_id, :dst_account_id, :amount, :type, :scheduled_date))
  end


end
