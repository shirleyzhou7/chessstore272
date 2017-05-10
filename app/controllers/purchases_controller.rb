class PurchasesController < ApplicationController
  #before_action :check_login
  
  def index
    @purchases = Purchase.chronological.paginate(:page => params[:page]).per_page(7)
  end

  def new
    @purchase = Purchase.new
  end

  def create
    
    @purchase = Purchase.new(purchase_params)
    @purchase.date = Date.current
    respond_to do |format|
      if @purchase.save
        @item = @purchase.item
        
        format.html{ redirect_to home_path, notice: "Successfully added a purchase for #{@purchase.quantity} #{@purchase.item.name}."}
        format.json
        format.js 
      else
        #render action: 'new'
      end
    end
  end

  private
  def purchase_params
    params.require(:purchase).permit(:item_id, :quantity)
  end
  
end