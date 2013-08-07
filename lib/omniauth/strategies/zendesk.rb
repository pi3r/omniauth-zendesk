require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Zendesk < OmniAuth::Strategies::OAuth2
      class AccountError < ArgumentError; end

      option :scope, 'read write'
      option :token_params, {
        :grant_type => 'authorization_code'
      }

      def request_phase
        session['omniauth.zendesk.account'] = fetch_zendesk_account

        set_omniauth_zendesk_urls

        super
      end

      def callback_phase
        set_omniauth_zendesk_urls

        super
      end

      def token_params
        options.token_params[:scope] = options[:scope]

        super
      end

      private
      def fetch_zendesk_account
        env["rack.request.query_hash"].fetch("account") do
          raise AccountError.new "account key needed in query string"
        end
      end

      def set_omniauth_zendesk_urls
        account = session['omniauth.zendesk.account']

        options["client_options"] = {
          :site => "https://#{account}.zendesk.com",
          :authorize_url => "https://#{account}.zendesk.com/oauth/authorizations/new",
          :token_url => "https://#{account}.zendesk.com/oauth/tokens"
        }
      end
    end
  end
end
