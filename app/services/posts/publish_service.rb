# frozen_string_literal: true

module Posts
  class PublishService < BaseService
    def call(post:, listeners: [])
      if post.published_at.nil?
        if post.update(published_at: Time.current)
          notify(listeners, :publish_success, post)
        else
          notify(listeners, :publish_failure, post, :update_failed)
        end
      else
        notify(listeners, :publish_failure, post, :already_published)
      end
    end
  end
end
