# frozen_string_literal: true

require 'csv'

module Adapters
  class CSVWriterService < BaseService
    def call(columns:, rows:)
      csv = []
      csv << CSV.generate_line(columns)
      csv += rows.map do |row|
        CSV.generate_line(row)
      end
      csv.join
    end
  end
end
