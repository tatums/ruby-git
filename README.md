
## What the shit is this?

We're wanting to do content versioning and this is a spike to see how feasible
it would be to us git to hadle the complexity of versions.

The idea is to use AWS CodeCommit

## Environment Variables
export AWS_DEFAULT_PROFILE=personal
export PROJECT_NAME=article-git-versions

## setup
Generate a id_rsa key and upload it to a user in AWS

Retreive the "SSH key ID" from the AWS web console after you upload the
id_rsa.pub key

    $ cat ~/.ssh/config
    =>
    Host git-codecommit.*.amazonaws.com
      User APKAJF44TPOEWHIEADZA
      IdentityFile ~/.ssh/id_rsa

## commit a file
    g = Git.clone("ssh://git-codecommit.us-east-1.amazonaws.com/v1/repos/my-first-code-commit-repo",
        "my-first-code-commit-repo",
        :path => '/tmp/')

    File.open("/tmp/my-first-code-commit-repo/Article.md", 'w') { |file| file.write("## Hello World! \n") }
    g.add('Article.md')
    g.commit('add Article.md!')
    g.push
