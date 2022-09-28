# frozen_string_literal: true

module Posts
  class DestroyService < BaseService
    def call(post:, listeners: [])
      post.destroy.tap do |result|
        notify(listeners, result ? :destroy_success : :destroy_failure, result)
      end
    end
  end
end
