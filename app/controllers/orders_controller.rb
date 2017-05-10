class OrdersController < ApplicationController
	before_action :set_order, only: [:show, :edit, :update, :destroy]
	include ChessStoreHelpers
	include Shipping
	include Cart

	def index
		authorize! :index, @order
		@orders = Order.chronological.paginate(:page => params[:page]).per_page(7)
	end

	def show
		@oi = @order.order_items
	end

	def new
		@order = Order.new
	end

	def edit
		autorize! :edit, @order
	end

	def create
		@order = Order.new(order_params)
		@order.user = current_user 
		@order.date = Date.today
		@order.grand_total = calculate_cart_items_cost + calculate_cart_shipping
		unless @order.expiration_month.nil?
			@order.expiration_month = @order.expiration_month.to_i
		end
		unless @order.expiration_year.nil?
			@order.expiration_year = @order.expiration_year.to_i
		end
		if @order.save
			save_each_item_in_cart(@order)
			@order.pay
			clear_cart
			
			redirect_to home_path, notice: "Successfully created order."
		else 
			render action: 'new'
		end
	end

	def update
		if @order.update(order_params)
			redirect_to order_path(@order), notice: "Successfully updated order."
		else
			render action: 'edit'
		end
	end


	def destroy
	    @order.destroy
	    redirect_to orders_path, notice: "Successfully removed order from the system."
  	end

  	def saveincart
  		save_each_item_in_cart(@order)
  	end
  	private

  	def set_order
  		@order = Order.find(params[:id])
  	end

  	def order_params
  		params.require(:order).permit(:school_id, :expiration_year, :expiration_month, :credit_card_number)
  	end
end
