require 'rails_helper'

describe ::Api::V1::Issues, type: :request do
  describe 'GET /api/v1/issues/:number/events' do
    let(:events_params) do
      [
        {
          'action' => 'opened',
          'issue'  => {
            'url'    => 'https://api.github.com/repos/octocat/Hello-World/issues/1349',
            'number' => 1349,
          },
        },
        {
          'action' => 'opened',
          'issue'  => {
            'url'    => 'https://api.github.com/repos/octocat/Hello-World/issues/1347',
            'number' => 1347,
          },
        }
      ]
    end

    let(:header_params) do
      {
        'Authorization' => ActionController::HttpAuthentication::Basic.encode_credentials('test@gmail.com', '123456'),
      }
    end
    let(:delivery) { SecureRandom.uuid }

    before do
      events_params.each do |params|
        Fabricate :event, event_type: :issues, payload: params, delivery: delivery
      end
    end

    let(:path) { '/api/v1/issues/1347/events' }

    before { get_action(path: path, header_params: header_params) }

    it 'return event' do
      expect(response).to have_http_status(:ok)

      event = json.first
      expect(event['event_type']).to eql('issues')
      expect(event['delivery']).to eql(delivery)
      expect(event['payload']).to match({
        'action' => 'opened',
        'issue'  => {
          'url'    => 'https://api.github.com/repos/octocat/Hello-World/issues/1347',
          'number' => 1347,
        },
      })
    end
  end
end
