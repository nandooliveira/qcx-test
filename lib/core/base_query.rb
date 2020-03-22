module Core
  class BaseQuery
    extend Dry::Initializer

    module Types
      include Dry.Types()
    end
  end
end
