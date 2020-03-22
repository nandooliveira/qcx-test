require 'rails_helper'

describe ::Api::V1::Webhooks, type: :request do
  let(:path)       { '/api/v1/webhooks/handle' }
  let(:params)     { { 'text' => 'test' } }
  let(:delivery)   { SecureRandom.uuid }
  let(:event_type) { 'ping' }
  let(:signature)  { 'sha1=3df329a3019efb05867bc9ea8d4d9a6b126cb3e5' }
  let(:header_params) do
    {
      'X-Github-Delivery' => delivery,
      'X-Github-Event'    => event_type,
      'X-Hub-Signature'   => signature,
    }
  end

  before { post_action(path: path, params: params, header_params: header_params) }

  it 'Create a new event' do
    expect(response).to have_http_status(:created)
  end
end
