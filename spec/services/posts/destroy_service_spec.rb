# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::DestroyService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call(post: post, listeners: [listener]) }

    let(:listener) { double('SomeListener', destroy_failure: nil, destroy_success: nil) }
    let(:post) { instance_double(PostEntity) }

    context 'when the destroy method succeed' do
      before { allow(PostsRepository).to receive(:destroy).and_return(post) }

      it 'sends the destroy message to the post', :aggregate_failures do
        call
        expect(PostsRepository).to have_received(:destroy).with(post)
        expect(listener).to have_received(:destroy_success).with(post)
      end
    end

    context 'when the destroy method fails' do
      before { allow(PostsRepository).to receive(:destroy).and_return(false) }

      it 'notifies the listeners of the failure' do
        call
        expect(listener).to have_received(:destroy_failure).with(false)
      end
    end
  end
end
