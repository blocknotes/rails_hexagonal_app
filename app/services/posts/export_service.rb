# frozen_string_literal: true

module Posts
  class ExportService < BaseService
    def call
      columns = ['Title', 'Author', 'Published at']
      posts = Post.all.annotate('export posts').to_a
      rows = posts.map { |post| [post.title, post.author.name, post.published_at] }
      Adapters::CSVWriterService.call(columns: columns, rows: rows)
    end
  end
end
