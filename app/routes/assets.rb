module Cms
  module Routes
    class Assets < Base
      configure do
                    set :assets, assets = Sprockets::Environment.new(settings.root)
                    assets.append_path('app/assets/javascripts')
                    assets.append_path('app/assets/stylesheets')
      end
            
      # get '/assets/*' do
#         env['PATH_INFO'].sub!(%r{^/assets}, '')
#         settings.assets.call(env)
#       end
    end
  end
end