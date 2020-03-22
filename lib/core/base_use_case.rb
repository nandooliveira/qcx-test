module Core
  class BaseUseCase
    extend Dry::Initializer

    module Types
      include Dry.Types()
    end
  end
end
