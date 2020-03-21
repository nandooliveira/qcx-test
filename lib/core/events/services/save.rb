module Core
  module Events
    module Services
      class Save < ::Core::BaseService
        option :event, Types::Instance(::Event), reader: :private

        def call
          event.tap(&:save)
        end
      end
    end
  end
end
