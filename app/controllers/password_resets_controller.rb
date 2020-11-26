class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update] 

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "パスワード再設定用のメールを送信しました。"
      redirect_to root_url
    else
      flash.now[:danger] = "入力されたメールアドレスは登録されていません。"
      render 'new'
    end
  end

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated,    true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = "登録が完了しました！"
      redirect_to user 
    else
      flash[:danger] = "リンクが無効です。"
      redirect_to root_url
    end
  end

def update
  if params[:user][:password].empty?
    @user.errors.add(:password, :blank)
    render 'edit'
  elsif @user.update(user_params)
    log_in @user
    flash[:success] = "パスワードが変更されました。"
    redirect_to @user
  else
    render 'edit'
  end
end

private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  # beforeフィルタ

  def get_user
    @user = User.find_by(email: params[:email])
  end

  # 有効なユーザーかどうか確認する
  def valid_user
    unless (@user && @user.activated? &&
            @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end
  end

  # トークンが期限切れかどうか確認する
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "パスワード変更リンクの有効期限が切れました。"
      redirect_to new_password_reset_url
    end
  end
end