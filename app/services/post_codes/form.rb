module PostCodes
  module Type
    include Dry.Types()

    Code = String.default(''.freeze)
  end

  class Form < Dry::Struct
    extend ActiveModel::Naming

    include ActiveModel::AttributeMethods

    attribute :code, Type::Code

    def persisted?
      false
    end

    def to_key
      ['post_code']
    end

    def to_model
      self
    end
  end
end
