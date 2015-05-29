module FatTag
  class GithubAuth
    def username
      config['basic']['username']
    end

    def password
      config['basic']['password']
    end

    def filepath(path = '/config/github_auth.yml')
      @filepath ||= SINATRA_ROOT + path
    end

    private

    def config
      YAML.load_file(filepath)
    end 
  end
end