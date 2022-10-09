# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::PublishService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call(post: post) }

    let(:author) { Author.new(email: 'some@email.it') }

    context 'with a post with published_at nil' do
      let(:post) { double(PostEntity, published_at: nil) }

      before { allow(PostsRepository).to receive(:update).and_return(true) }

      it 'publishes the post', :freeze_time do
        call
        expect(PostsRepository).to have_received(:update).with(post, published_at: Time.current)
      end
    end

    context 'with a published post' do
      let(:post) { double(PostEntity, published_at: 1.day.ago) }

      before { allow(PostsRepository).to receive(:update).and_return(true) }

      it 'exits without updating the post' do
        call
        expect(PostsRepository).not_to have_received(:update)
      end
    end

    context 'with a listener' do
      subject(:call) { service_class.call(post: post, listeners: [listener]) }

      let(:listener) { double('SomeListener', publish_failure: nil, publish_success: nil) }

      context 'when the publishing is successful' do
        let(:post) { double(PostEntity, published_at: nil) }

        before { allow(PostsRepository).to receive(:update).and_return(true) }

        it 'notifies the listeners of the success' do
          call
          expect(listener).to have_received(:publish_success).with(post)
        end
      end

      context 'when the publishing is failing' do
        let(:post) { double(PostEntity, published_at: nil) }

        before { allow(PostsRepository).to receive(:update).and_return(false) }

        it 'notifies the listeners of the failure' do
          call
          expect(listener).to have_received(:publish_failure).with(post, :update_failed)
        end
      end

      context 'with an already published post' do
        let(:post) { double(PostEntity, published_at: Time.current) }

        it 'notifies the listeners of the failure' do
          call
          expect(listener).to have_received(:publish_failure).with(post, :already_published)
        end
      end
    end
  end
end
