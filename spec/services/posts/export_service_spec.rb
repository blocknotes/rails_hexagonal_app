# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::ExportService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call(listeners: [listener]) }

    let(:listener) { double('SomeListener', export_success: nil) }

    context 'with no posts' do
      it "exports the empty posts' list", :aggregate_failures do
        csv_data = <<~CSV
          Title,Author,Published at
        CSV
        expect(call).to eq csv_data
        expect(listener).to have_received(:export_success).with(csv_data)
      end
    end

    context "with some posts' list" do
      let(:author) { Author.new(email: 'some@email.it') }

      before do
        3.times { |i| Post.create!(author: author, title: "Some post #{i + 1}") }
      end

      it 'exports the posts', :aggregate_failures do
        csv_data = <<~CSV
          Title,Author,Published at
          Some post 1,,
          Some post 2,,
          Some post 3,,
        CSV
        expect(call).to eq csv_data
        expect(listener).to have_received(:export_success).with(csv_data)
      end
    end
  end
end
