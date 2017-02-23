require 'rails/railtie'
require 'rollbar/plugins/rails/railtie_mixin'

module Rollbar
  class Railtie < ::Rails::Railtie
    include Rollbar::RailtieMixin

    initializer 'rollbar.middleware.rails' do |app|
      require 'rollbar/middleware/rails/rollbar'
      require 'rollbar/middleware/rails/show_exceptions'

      app.config.middleware.insert 0, Rollbar::Middleware::Rails::RollbarMiddleware
      ActionDispatch::DebugExceptions.send(:include, Rollbar::Middleware::Rails::ShowExceptions)
    end
  end
end

