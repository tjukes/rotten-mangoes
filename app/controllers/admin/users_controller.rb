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

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_path, notice: "#{@user.firstname} #{@user.lastname}'s account was submitted successfully!"
    else
      render :new
    end
  end

end
