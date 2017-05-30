require 'sinatra'
require 'sinatra/base'
require "sinatra/reloader"
require "sinatra/namespace"
require "git"
require "pry"

require_relative "login"
require_relative "api"
require_relative "api"
require_relative "serializers/repo"

REPOSITORY = "ssh://git-codecommit.us-east-1.amazonaws.com/v1/repos/my-first-code-commit-repo"
GIT_DIR = "my-first-code-commit-repo.git"

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  register Sinatra::Namespace

  use Login

  use Api

  get '/' do
    erb :index
  end

  namespace "/clone" do

    def get_repo
      #user_name = session[:user_name].downcase
      repo_name = "#{user_name}:my-first-code-commit-repo"
      repo_path = "data_store/#{repo_name}"
      repo = if Dir.exist?(repo_path)
        Git.open(repo_path)
      else
        Git.clone(REPOSITORY, repo_path)
      end
      repo.fetch
      repo
    end

    get '/' do
      @repo = get_repo
      erb :"clone/index"
    end

    get '/edit/:branch' do
      user_name = session[:user_name].downcase
      repo_name = "#{user_name}:my-first-code-commit-repo"
      repo_path = "data_store/#{repo_name}"
      @repo = get_repo
      @article = File.read("#{repo_path}/Article.md")
      erb :edit
    end

    post '/edit/:branch' do

      g = get_repo
      branch_name =  begin
                       sha256 = Digest::SHA256.new
                       sha256.digest(params[:article])
                       sha256.hexdigest
                     end
      g.branch(branch_name)

      g.push
      redirect '/'
    end



  end

  namespace "/bare" do
    def get_bare_repo
      g = if Dir.exist?(GIT_DIR)
            Git.open(GIT_DIR, repository: GIT_DIR)
          else
            Git.clone(REPOSITORY, GIT_DIR, bare: true)
          end
      g.fetch
      g
    end

    get '/' do
      @repo = get_bare_repo
      erb :"bare/index"
    end

  end
end
