# frozen_string_literal: true

module Posts
  class LoadService < BaseService
    def call(id)
      PostsRepository.find(id)
    end
  end
end
