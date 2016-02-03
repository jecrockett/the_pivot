class StachesController < ApplicationController
  # helper :headshot

  def index
    @staches = Stache.all
  end

  def show
    @stache = Stache.find(params[:id])
    session[:cam_stache_id] = @stache.id
  end

  def stached
    @stache = Stache.find(params[:stache_id])
    @photo = current_user.headshot_photos.last
  end

end
