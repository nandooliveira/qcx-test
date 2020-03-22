module Core
  module Webhooks
    module Services
      class BaseHandleWebhookEvent < ::Core::BaseService
        option :event_type, Types::String, reader: :private
        option :delivery,   Types::String, reader: :private
        option :signature,  Types::String, reader: :private
        option :payload,    Types::Hash,   reader: :private

        def call
          create_event
        end

        private

        def create_event
          ::Core::Events::Services::Save.new(event: event).call
        end

        def event
          ::Event.new(
            event_type: event_type,
            delivery:   delivery,
            signature:  signature,
            payload:    payload
          )
        end
      end
    end
  end
end
