require_relative './spec_helper.rb'

describe 'defaultnamer' do
  let(:namer) { FatTag::DefaultNamer.new }

  it 'sets the name with a time string' do
    namer.set.must_equal Time.now.strftime("%Y%m%d-%H%M")
  end
end

describe 'githubauth' do
  let(:auth) { FatTag::GithubAuth.new }

  it 'sets a default path' do
    auth.filepath.must_equal SINATRA_ROOT + '/config/github_auth.yml'
  end

  it 'sets a nondefault path' do
    auth.filepath('/spec/fixtures/spec_github_auth.yml').must_equal( 
      SINATRA_ROOT + '/spec/fixtures/spec_github_auth.yml')
  end

  it 'sets a username' do
    auth.filepath('/spec/fixtures/spec_github_auth.yml')
    auth.username.must_equal 'default_user'
  end

  it 'sets a password' do
    auth.filepath('/spec/fixtures/spec_github_auth.yml')
    auth.password.must_equal 'default_password'
  end
end

describe 'httpform' do
  let(:post_data) { FatTag::ReleaseData.call(target_commitish: '1234566789') }
  let(:post_request) { FatTag::PostRequest.new(data: post_data) }
  let(:http_form) { FatTag::HttpForm.new(request: post_request, organization: 'bar', repo: 'foo') }

  it 'successfully posts a request to the github api' do 
    response = http_form.call
    response.code.must_equal '201'
  end
end

describe 'postrequest' do
  let(:post_data) { FatTag::ReleaseData.call(target_commitish: '1234566789') }
  let(:post_request) { FatTag::PostRequest.new(data: post_data, path: "/foo") }

  it 'creates a http post request' do
    assert post_request.call.class, Net::HTTP::Post
  end
end

describe 'releasedata' do
  let(:post_data) { FatTag::ReleaseData.new(target_commitish: '1234566789') }

  it 'creates a release data hash' do
    body = post_data.call
    assert body.class, Hash
  end

  it 'sets the target_commitish' do
    body = post_data.call
    assert body['target_commitish'], '123456789'
  end

  it 'sets a tagname' do
    body = post_data.call
    body['tag_name'].length.must_be :>, 0
  end
end

