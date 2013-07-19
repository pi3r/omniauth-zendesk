require 'spec_helper'
require 'pry'

describe OmniAuth::Strategies::Zendesk do
  let(:app){ Rack::Builder.new do |b|
    b.use Rack::Session::Cookie, {:secret => "abc123"}
    b.use OmniAuth::Strategies::Zendesk
    b.run lambda{|env| [200, {}, []]}
  end.to_app }

  let(:account) { "services" }


  it "has default token_params" do
    strat = OmniAuth::Strategies::Zendesk.new('adasd', 'asdasdasd')

    expect(strat.token_params.to_hash).to eq({
                                                 "grant_type" => 'authorization_code',
                                                 "scope" => 'read write'
                                               })
  end

  it "allows scope modification from options" do
    strat = OmniAuth::Strategies::Zendesk.new('adasd', 'asdasdasd', { :scope => 'read' })

    expect(strat.token_params.to_hash).to eq({
                                                 "grant_type" => 'authorization_code',
                                                 "scope" => 'read'
                                               })
  end

  context "request phase" do
    context "without an account parameter" do
      it "raises an error" do
        expect{ get '/auth/zendesk' }.to raise_error(OmniAuth::Strategies::Zendesk::AccountError)
      end
    end

    context "with an account parameter" do
      before(:each) { get "/auth/zendesk?account=#{account}" }

      it "sets the account in session" do
        expect(last_request.env["rack.session"]["omniauth.zendesk.account"]).to eql account
      end

      it "calls the right authorize_url" do
        expect(last_response.header["Location"]).to match("https://#{account}.zendesk.com/oauth/authorizations/new")
      end
    end
  end
end
