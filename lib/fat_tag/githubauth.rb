module FatTag
  class GithubAuth
    def username
      config['basic']['username']
    end
    def password
      config['basic']['password']
    end

    def config
      YAML.load_file(filepath)
    end

    def filepath
      SINATRA_ROOT + '/config/github_auth.yml'
    end
  end
end