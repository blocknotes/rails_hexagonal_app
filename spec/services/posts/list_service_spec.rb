# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::ListService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call }

    context 'with no posts' do
      it "returns the empty posts' list" do
        expect(call).to eq []
      end
    end

    context "with some posts' list" do
      let(:author) { Author.new(email: 'some@email.it') }
      let(:posts) do
        3.times.map { |i| Post.create!(author: author, title: "Some post #{i + 1}") }
      end

      it 'exports the posts' do
        posts
        expect(call).to match_array posts
      end
    end
  end
end
