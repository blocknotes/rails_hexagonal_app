# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::PublishService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call(post: post) }

    let(:author) { Author.new(email: 'some@email.it') }

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

    context 'with a listener' do
      subject(:call) { service_class.call(post: post, listeners: [listener]) }

      let(:listener) { double('SomeListener', publish_failure: nil, publish_success: nil) }

      context 'when the publishing is successful' do
        let(:post) { instance_double(Post, published_at: nil, update: true) }

        it 'notifies the listeners of the success' do
          call
          expect(listener).to have_received(:publish_success).with(post)
        end
      end

      context 'when the publishing is failing' do
        let(:post) { instance_double(Post, published_at: nil, update: false) }

        it 'notifies the listeners of the failure' do
          call
          expect(listener).to have_received(:publish_failure).with(post, :update_failed)
        end
      end

      context 'with an already published post' do
        let(:post) { instance_double(Post, published_at: Time.current, update: false) }

        it 'notifies the listeners of the failure' do
          call
          expect(listener).to have_received(:publish_failure).with(post, :already_published)
        end
      end
    end
  end
end
