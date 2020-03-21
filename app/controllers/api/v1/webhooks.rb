module Api
  module V1
    class Webhooks < ::Grape::API
      resource :webhooks do
        desc 'Return Status'
        post :handle do
          event_type = headers['Secret-Password']

          ::Core::Webhooks::UseCases::Handle.new(
            event_type: event_type,
            params:     {}
          ).call

          present({ message: 'Event Received' })
        end
      end
    end
  end
end
