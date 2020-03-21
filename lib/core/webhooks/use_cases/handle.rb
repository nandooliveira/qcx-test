module Core
  module Webhooks
    module UseCases
      class Handle
        def initialize(event_type:, params:)
          @event_type = event_type
          @params     = params

          validate_params
        end

        def call
          handle_webhook
        end

        attr_reader :event_type, :params

        def handle_webhook
          service_class = "::Core::Webhooks::Services::Handle#{event_type.camelize}WebhookEvent".constantize
          service_class.new(params: params).call
        rescue NameError
          { message: "Unknown event \"#{event_type}\"!" }
        end

        def validate_params
          raise ::Core::Exceptions::ArgumentError, 'Parameter "event_type" is invalid!' \
            unless event_type.is_a?(::String)
          raise ::Core::Exceptions::ArgumentError, 'Parameter "params" is invalid!' \
            unless params.is_a?(::Hash)
        end
      end
    end
  end
end
