# frozen_string_literal: true

class BaseService
  class << self
    def call(*args)
      new.call(*args)
    end
  end
end
