class ApplicationController < ActionController::Base
  helper_method :current_user, :random_stache, :current_admin?, :current_user_id
  protect_from_forgery with: :exception
  before_action :set_cart
  before_action :store_location

  def store_location
    session[:forwarding_url] = request.path if request.get?
  end

  # def redirect_back_or(default = staches_path)
  #   redirect_to session[:forwarding_url] || default
  #   session.delete(:forwarding_url)
  # end

  def redirect_path(default)
    session[:attempted_donation] || default
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user_id
    current_user ? current_user.id : nil
  end

  def current_user_guard
    render file: "/public/404" unless current_user.id == params[:id].to_i
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def headshot_post_save(filepath)
    image_path = filepath.split("public")[1]
    @headshot = HeadshotPhoto.create(image_file_name: filepath.split("public")[1])
    current_user.headshot_photos << @headshot
  end

  def random_stache
    num = rand(1..4)
    "/assets/logos/#{num}.png"
  end

  def check_current_user
    if session[:forwarding_url] == new_order_path
      session[:want_to_checkout] = true
    end
    redirect_to login_path unless current_user
  end
end
