module Api
  module V1
    module Entities
      class EventResponseEntity < Grape::Entity
        format_with(:iso_timestamp) { |dt| dt.iso8601 }

        expose :event_type, documentation: { type: 'String', desc: 'Type of event' }
        expose :delivery,   documentation: { type: 'String', desc: 'Github delivery UUID' }
        expose :payload,    documentation: { type: 'Hash', desc: 'Payload received from Github'}

        with_options(format_with: :iso_timestamp) do
          expose :created_at
          expose :updated_at
        end
      end
    end
  end
end
