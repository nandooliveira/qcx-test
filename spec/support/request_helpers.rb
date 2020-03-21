module Requests
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body)
    rescue StandardError
      response.body
    end
  end

  module Helpers
    def post_action(path:, token: nil, params: {})
      post path, params: params, headers: build_headers(token)
    end

    def put_action(path:, token: nil, params: {})
      put path, params: params, headers: build_headers(token)
    end

    def get_action(path:, token: nil, params: {})
      get path, params: params, headers: build_headers(token)
    end

    def delete_action(path:, token: nil, params: {})
      delete path, params: params, headers: build_headers(token)
    end

    private

    def build_headers(token)
      header_params = {
        'Accept'       => 'application/json',
        'Content-Type' => 'application/json',
      }

      header_params['Authorization'] = "Bearer #{token}" if token

      header_params
    end
  end
end
