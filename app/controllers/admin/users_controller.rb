class Admin::UsersController < ApplicationController
  before_filter :restrict_access_admin

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path(@user), notice: "Account saved"
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "#{@user.firstname} #{@user.lastname}'s account was submitted successfully!"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: "#{@user.firstname} #{@user.lastname}'s account was successfully deleted."
  end

  protected
  def user_params
    params.require(:user).permit(
      :firstname, :lastname, :email, :password
    )
  end
end
