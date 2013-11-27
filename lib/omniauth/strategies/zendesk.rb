require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Zendesk < OmniAuth::Strategies::OAuth2
      class AccountError < ArgumentError; end

      option :name, :zendesk

      option :scope, 'read write'

      option :token_params, {
        :grant_type => 'authorization_code'
      }

      option :client_options, {
        :authorize_url => "/oauth/authorizations/new",
        :token_url => "/oauth/tokens"
      }

      def initialize(*)
        super

        set_client_options!
      end

      private
      def set_client_options!
        options['client_options']['site'] = "https://#{account}.zendesk.com"
        options['token_params']['scope'] = options['scope']
      end

      def account
        @account ||= options.fetch 'account' do
          raise ArgumentError.new('The :account options is missing')
        end
      end
    end
  end
end
