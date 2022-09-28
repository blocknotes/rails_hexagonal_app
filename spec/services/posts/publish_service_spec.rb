# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::PublishService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call(post: post) }

    let(:author) { Author.new(email: 'some@email.it') }

    context 'with an invalid post' do
      it 'raises an exception' do
        post = Post.new(title: 'Some title', published_at: nil)
        post.save(validate: false)
        expect { described_class.call(post: post) }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end

    context 'with a post to publish' do
      let(:post) { Post.create!(author: author, title: 'Some title', published_at: nil) }

      it 'publishes the post', :freeze_time do
        expect { call }.to change(post, :published_at).from(nil).to(Time.current)
      end
    end

    context 'with a published post' do
      let(:post) { Post.create!(author: author, title: 'Some title', published_at: Time.current) }

      it 'exits without updating the post' do
        current_attributes = post.attributes
        call
        expect(post.reload.attributes).to eq current_attributes
      end
    end
  end
end
