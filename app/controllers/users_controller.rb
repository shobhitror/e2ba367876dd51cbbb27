class UsersController < ApplicationController
  def index
    users = User.all
    render :json => {users: users}
  end

  def show
    user = User.find_by(id: params[:id])
    if user.present?
      render :json => {user: user}
    else
      render :json => {errors: "user not found"}
    end
  end

  def create
    user = User.new(user_params)
    if user.save!
      render :json => {user: user}
    else
      render :json => {errors: user.errors}
    end
  end

  def update
    user = User.find_by(id: params[:id])
    if user.update!(user_params)
      render :json => {user: user}
    else
      render :json => {errors: user.errors}
    end
  end

  def typeahead
    users = User.where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{params[:input]}%", "%#{params[:input]}%", "%#{params[:input]}%")
    render :json => {users: users}
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user.destroy
      render :json => {users: []}
    else
      render :json => {errors: "user not found"}
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
