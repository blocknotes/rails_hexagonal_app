# frozen_string_literal: true

module Posts
  class CreateService < BaseService
    def call(attrs:, listeners: [])
      post = PostsRepository.init(attrs)
      PostsRepository.update(post, {}).tap do |result|
        notify(listeners, result ? :create_success : :create_failure, post)
      end
    end
  end
end
