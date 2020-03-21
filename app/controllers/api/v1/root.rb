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

      mount ::Api::V1::Status
    end
  end
end
