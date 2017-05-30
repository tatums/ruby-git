module Serializers
  class Repo

    def self.show(name)
      repo_path = "data_store/#{name}:my-first-code-commit-repo"
      article = File.read("#{repo_path}/Article.md")
      JSON.generate({article: article})
    end

    def self.index(repo)
      JSON.generate({
        branches: repo.branches.map { |b| b.name },
        log: repo.log.map { |l|
          {
            objectish: l.objectish,
            message: l.message,
            author: {
              name: l.author.name,
              date: l.author.date,
              email: l.author.email
            }
          }
        }
      })
    end
  end
end
