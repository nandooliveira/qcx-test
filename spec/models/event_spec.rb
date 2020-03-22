require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:event_type) }
    it { should validate_presence_of(:delivery) }
    it { should validate_presence_of(:signature) }
    it { should validate_presence_of(:payload) }
    it { should validate_inclusion_of(:event_type).in_array(::Event::EVENT_TYPES) }
  end
end
