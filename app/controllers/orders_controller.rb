class OrdersController < ApplicationController
	include ChessStoreHelpers
	include Shipping
	include Cart

	def index
		@orders = Order.chronological.paginate(:page => params[:page]).per_page(7)
	end

	def show

	end

	def new
		@order = Order.new
	end

	def edit
	end

	def create
		@order = Order.new(order_params)
		@order.user = current_user 
		@order.date = Date.today
		@order.grand_total = calculate_cart_items_cost + calculate_cart_shipping
		@order.
		if order.save
			redirect_to order_path(@order), notice: "Successfully created #{@order.name}."
		else 
			render action: 'new'
		end
	end

	def update
		if @order.update(order_params)
			redirect_to order_path(@order), notice: "Successfully updated #{@order.name}."
		else
			render action: 'edit'
		end
	end


	def destroy
	    @order.destroy
	    redirect_to orders_path, notice: "Successfully removed #{@order.name} from the system."
  	end

  	def saveincart
  		save_each_item_in_cart(@order)
  	end
  	private

  	def set_order
  		@order = Order.find(params[:id])
  	end

  	def order_params
  		params.require(:order).permit(:date, :grand_total, :payment_receipt)
  	end
end
