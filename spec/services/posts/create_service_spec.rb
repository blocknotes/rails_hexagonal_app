# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::CreateService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call(attrs: attrs, listeners: [listener]) }

    let(:attrs) { { name: 'Some name' } }
    let(:listener) { double('SomeListener', create_failure: nil, create_success: nil) }
    let(:post) { instance_double(PostEntity) }

    context 'when the save method succeed' do
      before { allow(PostsRepository).to receive_messages(init: post, update: true) }

      it 'creates a new instance and send the save message to the new post', :aggregate_failures do
        call
        expect(PostsRepository).to have_received(:init).with(attrs)
        expect(PostsRepository).to have_received(:update)
      end
    end

    context 'when the save method fails' do
      before { allow(PostsRepository).to receive_messages(init: post, update: false) }

      it 'notifies the listeners of the failure' do
        call
        expect(listener).to have_received(:create_failure).with(post)
      end
    end
  end
end
