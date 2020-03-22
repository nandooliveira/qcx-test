module Core
  class BaseService
    extend Dry::Initializer

    module Types
      include Dry.Types()
    end
  end
end
