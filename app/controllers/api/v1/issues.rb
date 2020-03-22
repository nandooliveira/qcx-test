module Api
  module V1
    class Issues < ::Grape::API
      resource :issues do
        http_basic do |email, password|
          email == ENV['EMAIL'] && password == ENV['PASSWORD']
        end

        route_param :number do
          desc "Return issue's events"
          params do
            requires :number, type: ::Integer, documentation: 'Issue Number'
          end
          get :events do
            events = ::Core::Issues::UseCases::Events.new(
              params: params.symbolize_keys
            ).call

            present events, with: ::Api::V1::Entities::EventResponseEntity
          end
        end
      end
    end
  end
end
