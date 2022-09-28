# frozen_string_literal: true

require 'csv'

module Posts
  class ExportService < BaseService
    def call
      posts = Post.all.annotate('export posts').to_a
      columns = ['Title', 'Author', 'Published at']
      csv = []
      csv << CSV.generate_line(columns)
      csv += posts.map { |post| CSV.generate_line([post.title, post.author.name, post.published_at]) }
      csv.join
    end
  end
end
