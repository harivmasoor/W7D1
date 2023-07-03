class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end  
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to cats_path
    else
      render :new
    end
  end

    def destroy
      logout 
      redirect_to new_session_url
    end
    def user_params
      params.require(:user).permit(:username)
    end
end
