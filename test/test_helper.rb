require "simplecov"
SimpleCov.start "rails"

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require "rails/test_help"
require "capybara/rails"
require "minitest/pride"
require "mocha/mini_test"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include FactoryGirl::Syntax::Methods
  # Add more helper methods to be used by all tests here...
end

module ActionDispatch
  class IntegrationTest
    include Capybara::DSL

    def teardown
      reset_session!
    end

    def log_in(user)
      visit login_path
      fill_in "Username", with: user.username
      fill_in "Password", with: 'password'
      within '.main' do
        click_on "Login"
      end
    end

    def log_out
      click_on "Log Out"
    end

    def create_eight_orders_for_user
      user = create(:user)
      staches = create_list(:stache, 3)
      orders = create_list(:order, 8)
      quantities = (1..5).to_a

      orders.each do |order|
        staches.each do |stache|
          order.order_staches.create(stache_id: stache.id,
                                     quantity: quantities.sample)
        end
      end

      user.orders << orders
    end

    def featured_cause_user!
      User.create!(
      username:     'mike_dao',
      email:    'mike_dao@dreambuilder.com',
      password_digest: User.digest('password'),
      )
    end

    def create_featured_causes!
      Cause.create!(
      title: "Colonize The Moon",
      description: "Act now before Elon Musk owns the whole damn thing",
      image_url: "http://oi67.tinypic.com/eq2edd.jpg",
      goal: 1000000,
      user_id: User.find_by(email: "mike_dao@dreambuilder.com").id,
      category_id: Category.pluck(:id).sample)

      Cause.create!(
      title: "Potato Salad",
      description: "Leonard's greatest ambition is to make Potato Salad - help him achieve this noble goal",
      image_url: "https://www.omegafi.com/apps/home/wp-content/uploads/2015/08/potato-salad-the-good-one.jpg",
      goal: 13,
      user_id: User.find_by(email: "mike_dao@dreambuilder.com").id,
      category_id: Category.pluck(:id).sample)

      Cause.create!(
      title: "Squirrel Census",
      description: "Those furry little bastards have flown under the radar for far too long",
      image_url: "https://wallpaperscraft.com/image/skrat_squirrel_ice_age_ice_falling_63305_3840x1200.jpg",
      goal: 25000,
      user_id: User.find_by(email: "mike_dao@dreambuilder.com").id,
      category_id: Category.pluck(:id).sample)

      Cause.create!(
      title: "Ostrich Pillow",
      description: "Get your nap on anytime, anywhere",
      image_url: "http://www.crowdfunding-shop.com/uploads/1/1/8/9/11893290/s127856143605570547_p8_i1_w640.jpeg",
      goal: 3800,
      user_id: User.find_by(email: "mike_dao@dreambuilder.com").id,
      category_id: Category.pluck(:id).sample)
    end
  end
end
