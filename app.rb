require 'sinatra'
require "git"
require "pry"
require "sinatra/namespace"
require "sinatra/reloader" if development?

REPOSITORY = "ssh://git-codecommit.us-east-1.amazonaws.com/v1/repos/my-first-code-commit-repo"
GIT_DIR = "my-first-code-commit-repo.git"

def get_repo
  if Dir.exist?("my-first-code-commit-repo")
    Git.open("my-first-code-commit-repo")
  else
    Git.clone(REPOSITORY, "my-first-code-commit-repo")
  end
end


namespace "/clone" do
  get '/' do
    g = get_repo
    g.fetch
    "<ul>" + g.log.map {|l| "<li> #{l.message}</li>" }.join + "</ul>"
  end

  post '/edit/:id' do
    binding.pry
  end

  get '/edit' do
    g = get_repo
    g.fetch
    @article = File.read("my-first-code-commit-repo/Article.md")
    erb :edit
  end
end
namespace "/bare" do
  get '/' do
    g = if Dir.exist?(GIT_DIR)
          Git.open(GIT_DIR, repository: GIT_DIR)
        else
          Git.clone(REPOSITORY, GIT_DIR, bare: true)
        end
    g.fetch
    "<ul>" + g.log.map {|l| "<li> #{l.message}</li>" }.join + "</ul>"
  end
end

get '/' do
  "use /bare OR /clone"
end


