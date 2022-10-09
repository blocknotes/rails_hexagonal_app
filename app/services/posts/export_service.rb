# frozen_string_literal: true

module Posts
  class ExportService < BaseService
    def call(listeners: [])
      posts = PostsRepository.list_posts_with_authors
      csv_data = _prepare_csv_data(posts: posts)
      notify(listeners, :export_success, csv_data)
      csv_data
    end

    private

    def _prepare_csv_data(posts:)
      columns = ['Title', 'Author', 'Published at']
      rows = posts.map { |post| [post.title, post.author.name, post.published_at] }
      Adapters::CSVWriterService.call(columns: columns, rows: rows)
    end
  end
end
