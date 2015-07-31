module Cms
  module Routes
    class Base < Sinatra::Application
      configure do
        set :views, 'app/views'
        set :root, App.root
        enable :partial_underscores
        set :partial_template_engine, :erb
        
        enable :method_override
        disable :protection
        disable :static

        set :erb, escape_html: true,
                  layout_options: {views: 'app/views/layouts'}

        enable :use_code
      end

      PROJECT_TITLE ||= ENV['PROJECT_TITLE']
      
      register Extensions::Assets
      helpers Helpers
      helpers Sinatra::ContentFor
    end
  end
end