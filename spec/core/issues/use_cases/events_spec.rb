require 'rails_helper'

describe ::Core::Issues::UseCases::Events, :service do
  describe '.new' do
    context 'invalid params' do
      it 'raise_error' do
        [nil, '', [], 123].each do |params|
          expect { described_class.new(params: params) }.to raise_error(
            Dry::Types::ConstraintError
          )
        end
      end

      it 'raise_erro when key number does not exists' do
        expect { described_class.new(params: { test: 123 }) }.to raise_error(
          Dry::Types::MissingKeyError
        )
      end

      it 'raise_erro when key number is invalid' do
        ['', [], {}, nil].each do |number|
          expect { described_class.new(params: { number: number }) }.to raise_error(
            Dry::Types::SchemaError
          )
        end
      end
    end
  end

  describe '#call' do
    subject(:events) { described_class.new(params: { number: number }).call }

    context 'do not exist any event' do
      let(:number) { 1234 }

      it 'result is empty' do
        expect(events).to be_empty
      end
    end

    context 'when there are events' do
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

      before do
        events_params.each do |params|
          Fabricate :event, event_type: :issues, payload: params
        end
      end

      context 'when request events of a non existent issue' do
        let(:number) { 1234 }

        it 'empty result' do
          expect(events).to be_empty
        end
      end

      context 'when request events for an existent issue' do
        let(:number) { 1347 }

        it 'result with events for this issue number' do
          expect(events.count).to eq(1)
          expect(events.all? { |event| event.payload['issue']['number'] == number }).to be_truthy
        end
      end
    end
  end
end
