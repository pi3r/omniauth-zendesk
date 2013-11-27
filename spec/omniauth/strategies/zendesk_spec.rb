require 'spec_helper'
require 'pry'

describe OmniAuth::Strategies::Zendesk do
  let(:params) { [ 'id', 'secret', account: 'services' ] }

  context 'without the :account option' do
    it 'raises an ArgumentError' do

      expect {
        OmniAuth::Strategies::Zendesk.new('id', 'secret')
      }.to raise_error(ArgumentError, 'The :account options is missing')
    end
  end

  context 'with the :account option' do
    it 'does not raise an ArgumentError' do
      expect {
        OmniAuth::Strategies::Zendesk.new(*params)
      }.not_to raise_error
    end

    it 'sets the site url to the :account option' do
      strategy = OmniAuth::Strategies::Zendesk.new(*params)

      expect(strategy.options['client_options']['site'])
        .to eql('https://services.zendesk.com')
    end
  end
  it "has default token_params" do
    strategy = OmniAuth::Strategies::Zendesk.new(*params)

    expect(strategy.token_params.to_hash)
      .to eq({
               "grant_type" => 'authorization_code',
               "scope" => 'read write'
             })
  end
end
