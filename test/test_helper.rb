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
  end
end
