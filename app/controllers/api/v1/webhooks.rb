module Api
  module V1
    class Webhooks < ::Grape::API
      resource :webhooks do
        desc 'Return Status'
        post :handle do
          verify_signature(request.body.read)

          ::Core::Webhooks::UseCases::Handle.new(
            headers: headers,
            params:  params
          ).call

          present({ message: 'Event Received' })
        end
      end
    end
  end
end
