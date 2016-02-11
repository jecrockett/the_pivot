class TweetsController < ApplicationController

  def new
    @cause = Cause.find(params["cause_id"])
    @value = set_value
    @tweet = "Your Tweet"
  end

  def create
    TwitterService.new(current_user).tweet(params["Your Tweet"]["content"])
    redirect_to user_path(current_user)
  end

  private

    def set_value
      if params["cause_type"] == "supported"
        "Just donated to #{@cause.title} on DreamBuilder.com!"
      elsif  params["cause_type"] == "managed"
        "Help me reach my dream! Support #{@cause.title} on DreamBuilder.com!"
      else
        ""
      end
    end
end
