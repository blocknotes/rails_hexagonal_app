# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::LoadService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call(post_id) }

    context 'with no posts' do
      let(:post_id) { 1 }

      it "returns the empty posts' list" do
        expect { call }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context 'with some posts' do
      let(:author) { Author.new(email: 'some@email.it') }
      let(:post_id) { 1001 }
      let(:post1) { Post.create!(id: post_id, author: author, title: 'First post') }

      it 'loads the post' do
        post1
        expect(call).to eq post1
      end
    end
  end
end
