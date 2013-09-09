class TransferController < ApplicationController
  before_filter :authenticate_user! 

  def index
  	@transfers=current_user.transfers
  end

  def show
    @transfer=Transfer.find_by_id(params[:id])
  end

  def create
    @transfer=Transfer.create(params[:transfer].merge({user: current_user}))
    if (!@transfer.save)
      notice=@transfer.errors
    end
  end

  def delete
  end
end
