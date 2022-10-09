# frozen_string_literal: true

module Posts
  class UpdateService < BaseService
    def call(post:, attrs:, listeners: [])
      PostsRepository.update(post, attrs).tap do |result|
        notify(listeners, result ? :update_success : :update_failure, post)
      end
    end
  end
end
