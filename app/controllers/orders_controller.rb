class OrdersController < ApplicationController

	before action check_login

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
