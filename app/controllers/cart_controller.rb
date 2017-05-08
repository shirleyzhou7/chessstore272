class CartController < ApplicationController
	before_action :check_login
	
	include ChessStoreHelpers
	include Cart
	

	def new
		@cart = create_cart
		redirect_to yourcart_path
	end

	def index
		@items_in_cart = get_list_of_items_in_cart
		@total_cost = calculate_cart_items_cost
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

	def clearcart
		clear_cart
		redirect_to yourcart_path, notice: "Cleared cart."
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
