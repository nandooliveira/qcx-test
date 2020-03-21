require 'rails_helper'

describe ::Core::Events::Services::Save, :service do
  describe '.new' do
    context 'invalid event' do
      it 'raise error' do
        [1, nil, '', {}, []].each do |event|
          expect { described_class.new(event: event) }.to raise_error(
            Dry::Types::ConstraintError
          )
        end
      end
    end
  end

  describe '#call' do
    subject(:save_event) { described_class.new(event: event).call }

    context 'correct data' do
      let(:event) { Fabricate.build(:event) }

      it 'save the event' do
        expect { save_event }.to change { event.persisted? }.from(false).to(true)
      end
    end
  end
end
