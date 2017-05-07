class CartController < ApplicationController

	def new
		@cart = Cart.new
	end


	def add_to_cart
		@cart.add_item_to_cart
	end
end
