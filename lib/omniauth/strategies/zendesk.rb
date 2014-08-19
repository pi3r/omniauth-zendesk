require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Zendesk < OmniAuth::Strategies::OAuth2
      class AccountError < ArgumentError; end

      option :scope, 'read write'
      option :token_params, {
        :grant_type => 'authorization_code'
      }
      uid{
        host = URI( raw_info["user"]["url"] ).host.split(".").first
      }

      extra do
        {
          :raw_info => raw_info
        }
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get('/api/v2/users/me').body) if access_token
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end

      # Provide the "user" portion of the raw_info
      def user_info
        @user_info ||= raw_info.nil? ? {} : raw_info
      end


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
