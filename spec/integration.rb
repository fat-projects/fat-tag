require_relative './spec_helper.rb'

describe 'fat-tag app' do
  it 'should successfully post a release to the github API' do
    post '/api/8cf066a60f9e4cb733a05da7fee3f34a4433a434'
    last_response.status.must_be :==, 201
  end

  it 'should not successfully post a release to the github API' do
    post '/api/8cf066a60f9e4cb733a05da7fee3f34a4433a434'
    last_response.status.wont_be :==, 404
  end
end
