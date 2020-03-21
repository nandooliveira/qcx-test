require 'rails_helper'

describe ::Api::V1::Status, type: :request do
  describe 'GET /api/v1/status' do
    let(:path)   { '/api/v1/status' }

    before { get_action(path: path) }

    it 'return API Online message' do
      expect(response).to have_http_status(:ok)
      expect(json).to match({ 'status'=>'API Online' })
    end
  end
end
