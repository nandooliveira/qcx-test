require 'rails_helper'

describe ::Core::Webhooks::Services::BaseHandleWebhookEvent, :service do
  let(:signature)  { SecureRandom.hex(32) }
  let(:delivery)   { SecureRandom.uuid }
  let(:event_type) { 'ping' }
  let(:payload)    { { test: 'test' } }

  describe '.new' do
    context 'invaid event_type' do
      it 'raise error' do
        [1, [], {}, nil].each do |event_type|
          expect { described_class.new(event_type: event_type, signature: signature, delivery: delivery, payload: payload) }.to raise_error(
            Dry::Types::ConstraintError
          )
        end
      end
    end

    context 'invalid delivery' do
      it 'raise error' do
        [1, [], {}, nil].each do |delivery|
          expect { described_class.new(event_type: event_type, signature: signature, delivery: delivery, payload: payload) }.to raise_error(
            Dry::Types::ConstraintError
          )
        end
      end
    end

    context 'invalid signature' do
      it 'raise error' do
        [1, [], {}, nil].each do |signature|
          expect { described_class.new(event_type: event_type, signature: signature, delivery: delivery, payload: payload) }.to raise_error(
            Dry::Types::ConstraintError
          )
        end
      end
    end

    context 'invaid payload' do
      it 'raise error' do
        [1, [], '', nil].each do |payload|
          expect { described_class.new(event_type: event_type, signature: signature, delivery: delivery, payload: payload) }.to raise_error(
            Dry::Types::ConstraintError
          )
        end
      end
    end
  end

  describe '#call' do
    subject(:handle_event) { described_class.new(event_type: event_type, delivery: delivery, signature: signature, payload: payload).call }

    it 'create new event' do
      expect { handle_event }.to change(::Event, :count).by(1)
    end
  end
end
