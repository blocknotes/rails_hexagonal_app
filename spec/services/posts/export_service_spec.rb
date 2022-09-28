# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::ExportService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call }

    context 'with no posts' do
      it "exports the empty posts' list" do
        expect(call).to eq <<~CSV
          Title,Author,Published at
        CSV
      end
    end

    context "with some posts' list" do
      let(:author) { Author.new(email: 'some@email.it') }

      before do
        3.times { |i| Post.create!(author: author, title: "Some post #{i + 1}") }
      end

      it 'exports the posts' do
        expect(call).to eq <<~CSV
          Title,Author,Published at
          Some post 1,,
          Some post 2,,
          Some post 3,,
        CSV
      end
    end
  end
end
