class StaticController < ApplicationController
  def about
  end

  def home
    featured  = User.find_by(email: "mike_dao@dreambuilder.com").causes
    @moon     = featured.find_by(title: "Colonize The Moon")
    @potato   = featured.find_by(title: "Potato Salad")
    @squirrel = featured.find_by(title: "Squirrel Census")
    @ostrich  = featured.find_by(title: "Ostrich Pillow")
  end
end
