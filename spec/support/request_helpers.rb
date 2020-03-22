module Requests
  module JsonHelpers
    def json
      @json ||= JSON.parse(response.body)
    rescue StandardError
      response.body
    end
  end

  module Helpers
    def post_action(path:, params: {}, header_params: {})
      post path, params: params.to_json, headers: build_headers(header_params)
    end

    def put_action(path:, params: {}, header_params: {})
      put path, params: params, headers: build_headers(header_params)
    end

    def get_action(path:, params: {}, header_params: {})
      get path, params: params, headers: build_headers(header_params)
    end

    def delete_action(path:, params: {}, header_params: {})
      delete path, params: params, headers: build_headers(header_params)
    end

    private

    def build_headers(header_params)
      {
        'Accept'       => 'application/json',
        'Content-Type' => 'application/json',
      }.merge(header_params)
    end
  end
end
