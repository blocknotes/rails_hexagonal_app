# frozen_string_literal: true

module Posts
  class LoadService < BaseService
    def call(id)
      Post.find(id)
    end
  end
end
