class ItemPricesController < ApplicationController
  authorize_resource

  
  def index
    @active_items = Item.active.alphabetical.to_a
  end

  def new
    @item_price = ItemPrice.new
  end

  def create

    @item_price = ItemPrice.new(item_price_params)
    @item = @item_price.item
    @item_price.start_date = Date.current
    @price_history = @item.item_prices.chronological.to_a
    # everyone sees similar items in the sidebar
    @similar_items = Item.for_category(@item.category).active.alphabetical.to_a - [@item]
    respond_to do |format|
      if @item_price.save
        
        format.html { redirect_to item_path(@item), notice:  "Changed the price of #{@item.name}." }
        format.json { render action: 'show', status: :created, location: @item_price }
        #@item = @item_price.item
        #@item_prices = @item.item_prices.chronological.to_a
        format.js {render action: 'create'}
      else
        format.html{ render action: 'new' }
        #format.json { render json: @item_price.errors, status: :unprocessable_entity}
        format.js
      end
    end
  end

  private
  def item_price_params
    params.require(:item_price).permit(:item_id, :price, :category)
  end
  
end