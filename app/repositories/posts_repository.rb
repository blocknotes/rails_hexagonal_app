# frozen_string_literal: true

module PostsRepository
  module_function

  def destroy(post_entity)
    post_entity.destroy
  end

  def find(*args)
    post_record = Post.find(*args)
    PostEntity.load(post_record, with_relations: true)
  end

  def init(attrs)
    post_record = Post.new(attrs)
    PostEntity.new(post_record)
  end

  def list_posts_with_authors
    post_records = Post.includes(:author).all
    PostEntity.decorate_collection(post_records, with_relations: true)
  end

  def update(post_entity, attrs)
    post_entity.update(attrs)
  end
end
