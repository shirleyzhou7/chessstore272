class HomeController < ApplicationController
  def home
    @items_to_reorder = Item.need_reorder.alphabetical.to_a
    @orders_to_ship = Order.where('date'.nil?).to_a
    @orders = Order.chronological.paginate(:page => params[:page]).per_page(7)
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end