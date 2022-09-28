# frozen_string_literal: true

module Posts
  class UpdateService < BaseService
    def call(post:, attrs: nil)
      post.assign_attributes(attrs) if attrs
      post.save
    end
  end
end
