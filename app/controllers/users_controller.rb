class UsersController < ApplicationController

  def new
   @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
   @user = User.new(user_params)
   if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_url(@user)
   else
     render 'new'
   end
 end

 def index
 end

 def edit
   @user = User.find(params[:id])
   (flash[:success] = "You can't edit another's profile !"
   redirect_to(root_url) ) unless @user == current_user
 end

 def update
  @user = User.find(params[:id])
  if @user.update_attributes(user_params)
    flash[:success] = "Profile updated"
    redirect_to @user
  else
    render 'edit'
  end
end

   private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password,
                                   :password_confirmation)
    end



end
