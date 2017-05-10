class OrderItemsController < ApplicationController

	def create
		#call save item to cart method here
	end

	

	def ship
		@order_item = OrderItem.find(params[:id])
		@order_item.shipped
		redirect_to home_path
	end

	private
	def Order_item_params
    params.require(:order_item).permit(:order_id, :item_id, :quantity, :shipped_on)
  end
	
end
