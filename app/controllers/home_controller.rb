class HomeController < ApplicationController
  def home
    @items_to_reorder = Item.need_reorder.alphabetical.to_a
    @orders_to_ship = Order_item.unshipped.chronological.to_a
  end

  def about
  end

  def contact
  end

  def privacy
  end
  
end