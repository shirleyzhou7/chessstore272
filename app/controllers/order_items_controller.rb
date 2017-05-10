class OrderItemsController < ApplicationController

	def create
		#call save item to cart method here
	end

	

	def ship
		respond_to do |format| 
			@order_item = OrderItem.find(params[:id])
			@order_item.shipped
			@orders_to_ship = OrderItem.unshipped.to_a
			format.html 
			format.js
		end
		
	end

	private
	def Order_item_params
    params.require(:order_item).permit(:order_id, :item_id, :quantity, :shipped_on)
  end
	
end
