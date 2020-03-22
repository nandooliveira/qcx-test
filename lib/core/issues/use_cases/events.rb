module Core
  module Issues
    module UseCases
      class Events < ::Core::BaseUseCase
        option :params,  Types::Hash.schema(number: Types::Strict::Integer), reader: :private

        def call
          events
        end

        private

        def events
          ::Core::Events::Queries::Issues::ByNumber.new(number: params[:number]).call
        end
      end
    end
  end
end
