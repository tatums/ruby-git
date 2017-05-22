class Api < Sinatra::Base
  register Sinatra::Namespace
  configure :development do
    register Sinatra::Reloader
  end

  before { content_type 'application/json' }
  namespace "/api" do
    get "/" do
      {a: 1}.to_json
    end
  end
end
