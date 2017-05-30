class Api < Sinatra::Base

  REPOSITORY = "ssh://git-codecommit.us-east-1.amazonaws.com/v1/repos/my-first-code-commit-repo"
  GIT_DIR = "my-first-code-commit-repo.git"

  register Sinatra::Namespace
  configure :development do
    register Sinatra::Reloader
  end

  def get_repo
    user_name = "Tatum"
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

  before { content_type 'application/json' }

  namespace "/api" do
    get "/" do
      @repo = get_repo
      Serializers::Repo.index(@repo)
    end

    get '/edit/:branch' do
      ## state?
      get_repo
      name = "Tatum"
      Serializers::Repo.show(name)
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
    end

  end
end
