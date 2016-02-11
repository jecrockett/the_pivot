class TweetsController < ApplicationController

  def new
    cause = Cause.find(params["cause_id"])
    @value = set_value(cause)
    @tweet = "Your Tweet"
  end

  def create
    TwitterService.new(current_user).tweet(params["Your Tweet"]["content"])
    redirect_to user_path(current_user)
  end

  private

    def set_value(cause)
      if params["cause_type"] == "supported"
        "I donated to #{cause.title} on DreamBuilder.com!"
      elsif  params["cause_type"] == "managed"
        "Help #{cause.title} become a reality on DreamBilder.com!"
      else
        ""
      end
    end
end
