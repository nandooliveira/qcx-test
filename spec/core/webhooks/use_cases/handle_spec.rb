require 'rails_helper'

describe ::Core::Webhooks::UseCases::Handle do
  describe '.new' do
    context 'invalid event_type' do
      it 'raise error' do
        [1, nil, {}, []].each do |event_type|
          expect { described_class.new(event_type: event_type, params: {}) }.to raise_error(
            ::Core::Exceptions::ArgumentError,
            'Parameter "event_type" is invalid!'
          )
        end
      end
    end

    context 'invalid params' do
      it 'raise error' do
        [1, nil, '', []].each do |params|
          expect { described_class.new(event_type: 'issues', params: params) }.to raise_error(
            ::Core::Exceptions::ArgumentError,
            'Parameter "params" is invalid!'
          )
        end
      end
    end
  end

  describe '#call' do
    subject(:handle_event) do
      described_class.new(event_type: event_type, params: params).call
    end

    let(:params) { {} }

    context 'unknown event' do
      let(:event_type) { 'unknown_event' }

      it 'return a message' do
        expect(handle_event).to match(message: "Unknown event \"#{event_type}\"!")
      end
    end

    context 'any known event' do
      module Core
        module Webhooks
          module Services
            class HandleKnownEventWebhookEvent
              def initialize(params:); end
            end
          end
        end
      end

      let(:event_type)             { 'known_event' }
      let(:event_service)          { ::Core::Webhooks::Services::HandleKnownEventWebhookEvent }
      let(:event_service_instance) { double }

      before do
        allow(event_service).to receive(:new).with(params: params).and_return(event_service_instance)
        allow(event_service_instance).to receive(:call)
      end

      it 'call the service passing the params' do
        handle_event

        expect(event_service).to have_received(:new).with(params: params)
        expect(event_service_instance).to have_received(:call)
      end
    end
  end
end
