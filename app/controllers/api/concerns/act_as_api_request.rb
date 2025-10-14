# frozen_string_literal: true

module API
  module Concerns
    module ActAsAPIRequest
      extend ActiveSupport::Concern

      included do
        before_action :skip_session_storage
      end

      def skip_session_storage
        # Devise stores the cookie by default, so in api requests, it is disabled
        # http://stackoverflow.com/a/12205114/2394842
        request.session_options[:skip] = true
      end

      private

      def request_with_body?
        request.post? || request.put? || request.patch?
      end
    end
  end
end
