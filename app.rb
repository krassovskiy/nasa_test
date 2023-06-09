require 'bundler'

Bundler.require(:default)

class App < Dry::System::Container
  configure do |config|
    config.component_dirs.add 'lib'
  end
end

App.finalize!