class CartController < ApplicationController

	include ChesstoreHelpers
	include Cart
	

	def new
	end

	def show
		@items_in_cart = get_list_of_items_in_cart
		redirect_to cart_path, notice: "your cart is empty"
	end

	def create
		@cart = create_cart
		redirect_to home_path
	end

	def edit
	end

	def add_to_cart(item_id)
		@cart.add_item_to_cart(item_id)
		redirect_to home_path, notice: "Added an item to cart"

	end


	def destroy
		@cart.destroy_cart
		redirect_to root_url
	end
end
