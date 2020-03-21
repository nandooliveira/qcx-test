module Core
  module Webhooks
    module UseCases
      class Handle < ::Core::BaseUseCase
        option :headers, Types::Hash, reader: :private
        option :params,  Types::Hash, reader: :private

        def call
          handle_webhook
        end

        def handle_webhook
          service_class = "::Core::Webhooks::Services::Handle#{event_type.camelize}WebhookEvent".constantize
          service_class.new(service_params).call
        rescue NameError
          ::Core::Webhooks::Services::BaseHandleWebhookEvent.new(service_params).call
        end

        def service_params
          {
            event_type: event_type,
            delivery:   delivery,
            signature:  signature,
            payload:    params,
          }
        end

        def event_type
          @event_type ||= headers['X-Github-Event']
        end

        def delivery
          headers['X-Github-Delivery']
        end

        def signature
          headers['X-Hub-Signature']
        end
      end
    end
  end
end
