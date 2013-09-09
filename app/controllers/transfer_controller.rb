class TransferController < ApplicationController
  before_filter :authenticate_user! 

  def index
  	@transfers=current_user.transfers.reload
  end

  def show
    @transfer=Transfer.find_by_id(params.require(:id))
  end

  def new
    @transfer=Transfer.new
  end

  def create 
    
    if (params[:transfer])
      params.require(:transfer)            
      @transfer=Transfer.new(params[:transfer].permit(:src_account_id, :dst_account_id, :amount, :type, :scheduled_date))
    elsif (params[:abacaxi_transfer])
      params.require(:abacaxi_transfer)
      @transfer=Transfer.new(params[:abacaxi_transfer].permit(:src_account_id, :dst_account_id, :amount, :type, :scheduled_date))
    elsif (params[:bessouro_transfer])
      params.require(:bessouro_transfer)
      @transfer=Transfer.new(params[:bessouro_transfer].permit(:src_account_id, :dst_account_id, :amount, :type, :scheduled_date))
    elsif (params[:capibara_transfer])
      params.require(:capibara_transfer)
      @transfer=Transfer.new(params[:capibara_transfer].permit(:src_account_id, :dst_account_id, :amount, :type, :scheduled_date))
    elsif (params[:damasco_transfer])
      params.require(:damasco_transfer)
      @transfer=Transfer.new(params[:damasco_transfer].permit(:src_account_id, :dst_account_id, :amount, :type, :scheduled_date))
    end    

    @transfer.user=current_user

    respond_to do |format|
      if (@transfer.save)
        format.html { render action: 'index', notice: t('transfer.successfully_created') }
      else
        format.html { render action: 'new' }
      end
    end

  end

  def delete
    @transfer=Transfer.find_by_id(params.require(:id))
    @transfer.delete
  end

end
