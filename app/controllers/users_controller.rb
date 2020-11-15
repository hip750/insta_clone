class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "登録が完了しました！"
      redirect_to user_url(@user) #@user でも可
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:full_name, :name, :email,
                            :password, :password_confirmation)
    end
end
