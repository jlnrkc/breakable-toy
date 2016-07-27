class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  # def show
  #     @user = User.find_by_username(params[:id])
  #   if @user
  #     @faves = @user.faves.all
  #       render actions: :show
  # end
end
