require 'spec_helper'
# require 'webmock/rspec'; WebMock.disable_net_connect!(allow_localhost: true)

describe 'tests for ensuring Slack functionality' do
  context 'rspec up and running' do
    it 'should return this test as true' do
      expect("testing").to eql("testing")
    end
  end

  context 'methods in Slack Class' do
    it 'test auth should return ok' do
      parsed_response_ok = Slack.test.parsed_response['ok'] 
      expect(parsed_response_ok).to eql(true)
    end
  end
end