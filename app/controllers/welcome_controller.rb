class WelcomeController < ApplicationController
  def home

  end

  def admin
  end

  def new_user
    @user = User.new
  end
end
