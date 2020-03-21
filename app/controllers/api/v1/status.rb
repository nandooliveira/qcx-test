module Api
  module V1
    class Status < ::Grape::API
      resource :status do
        desc 'Return Status'
        get do
          present({ status: 'API Online' })
        end
      end
    end
  end
end
