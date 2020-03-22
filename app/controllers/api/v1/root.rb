module Api
  module V1
    class Root < ::Grape::API
      version 'v1', using: :path
      # Specific content type to set UTF-8 and avoid codification problems
      content_type :json, 'application/json; charset=UTF-8'
      format :json
      prefix :api

      before do
        # Allow CORS
        header['Access-Control-Allow-Origin'] = '*'
        header['Access-Control-Request-Method'] = '*'
      end

      def self.status_for_error(error)
        return 404 if error.is_a?(ActiveRecord::RecordNotFound)
        return 422 if error.is_a?(ActiveRecord::RecordInvalid)
        return error.status if error.respond_to?(:status)

        500
      end

      helpers do
        def verify_signature(payload_body)
          ENV['SECRET_TOKEN'] = 'd42fb616d55a3f066f066b9cf8aae59bc2479115c6e52a4ac70e30f49882b973'
          signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), ENV['SECRET_TOKEN'], payload_body)
          raise Grape::Exceptions::Validation, params: ['invalid signature'], message: "Signatures didn't match!" \
            unless Rack::Utils.secure_compare(signature, headers['X-Hub-Signature'])
        end
      end

      rescue_from :all do |error|
        status = ::Api::V1::Root.status_for_error(error)

        response_data = {
          error: {
            message: error.message,
            class:   error.class.name
          }
        }

        ::Rails.logger.error(error.message)
        Rack::Response.new([response_data.to_json], status, 'Content-type' => 'application/json')
      end

      mount ::Api::V1::Issues
      mount ::Api::V1::Status
      mount ::Api::V1::Webhooks
    end
  end
end
