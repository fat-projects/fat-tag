require 'net/http'
require 'uri'
require 'json'
require 'yaml'
require 'pathname'

require_relative './fat_tag/defaultnamer'
require_relative './fat_tag/githubauth'
require_relative './fat_tag/httpform'
require_relative './fat_tag/postrequest'
require_relative './fat_tag/releasedata'

SINATRA_ROOT = File.expand_path('../', __dir__)

module FatTag
  def self.post(commit_sha, github_repo)
    post_data = FatTag::ReleaseData.call(target_commitish: commit_sha)
    post_request = FatTag::PostRequest.new(data: post_data)
    FatTag::HttpForm.call(request: post_request, repo: github_repo)
  end
end
