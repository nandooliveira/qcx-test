module Core
  module Events
    module Queries
      module Issues
        class ByNumber < ::Core::BaseQuery
          option :number, Types::Integer, reader: :private

          def call
            ::Event.where(event_type: 'issues')
                   .where("payload->'issue'->>'number' = ?", number.to_s)
          end
        end
      end
    end
  end
end
