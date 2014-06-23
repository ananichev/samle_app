class UsersController < ApplicationController
  
  before_action :signed_in_user, 		only: [:index, :edit, :update]
  before_action :correct_user,   		only: [:edit, :update]
  before_action :admin_user,     		only: :destroy
  before_action :for_signed_in_users,   only: [:new, :create]
  
  def index
  	@users = User.paginate(page: params[:page])
  end
  	
  def show
  	@user = User.find(params[:id])
  end
  
  def new
  	@user = User.new
  end
  
  def create
  	@user = User.new(user_params)
  	if @user.save
  	  sign_in @user
  	  flash[:success] = "Wellcome to the Sample App!"
  	  redirect_to @user
  	else
  	  render 'new'
  	end
  end
  
  def edit
  	
  end
  
  def update
  	if @user.update_attributes(user_params)
  	  flash[:success] = "Profile updated!"
  	  redirect_to @user
  	else
  	  render 'edit'
  	end
  end
  
  def destroy
  	@user = User.find(params[:id])
  	if @user.admin?
  	  redirect_to root_url
  	else
  	  @user.delete
  	  flash[:success] = "User deleted!"
  	  redirect_to users_url
  	end
  end
  
  
  private
  
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def signed_in_user	#Если не вошли и пытамся что-то делать
  	unless signed_in?
  	  store_location
  	  redirect_to signin_url, notice: "Please sign in."
  	end
  end
  
  def correct_user     #Если вошли, но хотим поменять данные другого юзера
  	@user = User.find(params[:id])
  	redirect_to(root_url) unless current_user?(@user)
  end
  
  def admin_user
  	redirect_to(root_url) unless current_user.admin?
  end
  
  def for_signed_in_users
  	redirect_to(root_url) if signed_in?
  end

end
