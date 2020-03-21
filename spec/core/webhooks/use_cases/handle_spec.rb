require 'rails_helper'

describe ::Core::Webhooks::UseCases::Handle do
  describe '.new' do
    context 'invalid headers' do
      it 'raise error' do
        [1, nil, '', []].each do |headers|
          expect { described_class.new(headers: headers, params: {}) }.to raise_error(
            Dry::Types::ConstraintError
          )
        end
      end
    end

    context 'invalid params' do
      it 'raise error' do
        [1, nil, '', []].each do |params|
          expect { described_class.new(headers: 'issues', params: params) }.to raise_error(
            Dry::Types::ConstraintError
          )
        end
      end
    end
  end

  describe '#call' do
    subject(:handle_event) do
      described_class.new(headers: headers, params: params).call
    end

    let(:delivery)   { '89ec1780-6bc2-11ea-8f7a-bd2696ebe5aa' }
    let(:event_type) { 'ping' }
    let(:signature)  { 'sha1=12518a93a2cdb9f54ed8bd8af5eac45b24871f49' }
    let(:headers) do
      {
        'X-GitHub-Delivery' => delivery,
        'X-GitHub-Event'    => event_type,
        'X-Hub-Signature'   => signature,
      }
    end
    let(:params) { {} }

    context 'unknown event' do
      let(:event_type) { 'unknown_event' }

      it 'create using the generic service' do
        expect { handle_event }.to change(::Event, :count).by(1)
      end

      it 'create with correct data' do
        expect(handle_event.event_type).to eql(event_type)
        expect(handle_event.delivery).to eql(delivery)
        expect(handle_event.signature).to eql(signature)
      end
    end

    context 'any known event' do
      let(:event_type) { 'ping' }

      it 'create a event on database' do
        expect { handle_event }.to change(::Event, :count).by(1)
      end

      it 'create with correct data' do
        expect(handle_event.event_type).to eql(event_type)
        expect(handle_event.delivery).to eql(delivery)
        expect(handle_event.signature).to eql(signature)
      end

      context 'check if correct class is being called' do
        let(:event_service)          { ::Core::Webhooks::Services::HandlePingWebhookEvent }
        let(:event_service_instance) { spy }

        before do
          allow(event_service).to receive(:new).and_return(event_service_instance)
        end

        it 'call the service passing the params' do
          handle_event

          expect(event_service).to have_received(:new).with(
            event_type: event_type,
            delivery:   delivery,
            signature:  signature,
            payload:    params
          )
          expect(event_service_instance).to have_received(:call)
        end
      end
    end
  end
end
