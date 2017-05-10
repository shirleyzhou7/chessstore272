class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :addtocart, :removefromcart]
 
  

  include ChessStoreHelpers
  include Cart

  def index
    # get info on active items for the big three...
    @boards = Item.active.for_category('boards').alphabetical.paginate(:page => params[:page]).per_page(10)
    @pieces = Item.active.for_category('pieces').alphabetical.paginate(:page => params[:page]).per_page(10)
    @clocks = Item.active.for_category('clocks').alphabetical.paginate(:page => params[:page]).per_page(10)
    @supplies = Item.active.for_category('supplies').alphabetical.paginate(:page => params[:page]).per_page(10)    
    # get a list of any inactive items for sidebar
    @inactive_items = Item.inactive.alphabetical.to_a
    
  end

  def show
    # get the price history for this item
    @price_history = @item.item_prices.chronological.to_a
    # everyone sees similar items in the sidebar
    @similar_items = Item.for_category(@item.category).active.alphabetical.to_a - [@item]
  end

  def new
    authorize! :new, @item
    @item = Item.new
  end

  def edit
    authorize! :edit, @item
  end

  def create
    authorize! :create, @item
    @item = Item.new(item_params)
    if @item.save
      redirect_to item_path(@item), notice: "Successfully created #{@item.name}."
    else
      render action: 'new'
    end
  end

  def update
  
    if @item.update(item_params)
      redirect_to item_path(@item), notice: "Successfully updated #{@item.name}."
    else
      render action: 'edit'
    end
  end

  def addtocart
    item_id = @item.id.to_s
    add_item_to_cart(item_id)
    redirect_to items_path, notice: "Added #{@item.name} to cart"
  end

  def removefromcart
    item_id = @item.id.to_s
    remove_item_from_cart(item_id)
    redirect_to yourcart_path, notice: "Removed #{@item.name} from cart."
  end

  def destroy
    authorize! :destroy, @item
    @item.destroy
    redirect_to items_path, notice: "Successfully removed #{@item.name} from the system."
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :color, :category, :weight, :inventory_level, :reorder_level, :active, :photo)
  end
  
end