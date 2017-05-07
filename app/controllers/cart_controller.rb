class CartController < ApplicationController

	include ChessStoreHelpers
	include Cart
	

	def new
		@cart = create_cart
		redirect_to yourcart_path
	end

	def index
		@items_in_cart = get_list_of_items_in_cart
	end

	def show
		# if @cart.nil?
		# 	redirect_to home_path, notice: "your cart is empty"
		# else
			
		#end
		#redirect_to home_path, notice: "your cart is empty"
	end

	# def create	
	# end

	def edit
	end

	def add_to_cart(item_id)
		@cart= @cart.new(cart_params)
		#id = params[:id]
		@cart.add_item_to_cart(item_id)
		redirect_to yourcart_path, notice: "Added an item to cart"

	end


	def destroy
		@cart.destroy_cart
		redirect_to root_url
	end

	private
	def cart_params
		params.require(:item_id)
	end
end
