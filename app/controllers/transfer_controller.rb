class TransferController < ApplicationController
  before_filter :authenticate_user! 

  def index
  	@transfers=current_user.transfers
  end

  def show
    @transfer=Transfer.find_by_id(params.require(:id))
  end

  def create
    @transfer=Transfer.new(params.require(:transfer).permit(:src_account_id, :dst_account_id, :amount, :type, :scheduled_date) )
    @transfer.user=current_user

    if (!@transfer.save)      
      notice=@transfer.errors
    end
  end

  def delete
    @transfer=Transfer.find_by_id(params.require(:id))
    @transfer.delete
  end
end
