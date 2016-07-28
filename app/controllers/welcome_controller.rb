class WelcomeController < ApplicationController
  def index
    if user_signed_in?
      @faves = current_user.faves.includes(:pet)
      render :user_home
    else
      render :index
    end
  end
end
