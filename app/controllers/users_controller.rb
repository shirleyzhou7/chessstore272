class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	#load_and_authorize_resource

	def index
		authorize! :index, @user
		@users = User.alphabetical.paginate(:page => params[:page]).per_page(7)
	end

	def show
		authorize! :show, @user
		@user_orders = @user.orders.not_shipped.all.to_a

		#@created_tasks = Task.for_creator(@user.id).by_name
		#@completed_tasks = Task.for_completer(@user.id).by_name
	end

	def new
		@user = User.new
	end

	def edit
	end

	def create
		@user = User.new(user_params) 
		if @user.save
		  session[:user_id] = @user.id
		  redirect_to home_path, notice: "Thank you for signing up!"
		else
		  flash[:error] = "This user could not be created."
		  render "new"
		end
	end

	def update
		authorize! :update, @user
		if @user.update_attributes(user_params)
		  flash[:notice] = "#{@user.proper_name} is updated."
		  redirect_to @user
		else
		  render :action => 'edit'
		end
	end

	def destroy
		authorize! :update, @user
		@user.destroy
		flash[:notice] = "Successfully removed #{@user.proper_name} from Arbeit."
		redirect_to users_url
	end

	private
	def set_user
	  @user = User.find(params[:id])
	end

	def user_params
	  if current_user && current_user.role?(:admin)
	    params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation, :role, :active)  
	  else
	    params.require(:user).permit(:first_name, :last_name, :email, :username, :password, :password_confirmation, :active)
	  end
	end
	

end
