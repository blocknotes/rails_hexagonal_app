# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::UpdateService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call(post: post, attrs: attrs, listeners: [listener]) }

    let(:attrs) { { name: 'Some name' } }
    let(:listener) { double('SomeListener', update_failure: nil, update_success: nil) }
    let(:post) { instance_double(Post, update: true) }

    it 'sends the update message to the post', :aggregate_failures do
      call
      expect(post).to have_received(:update).with(attrs)
      expect(listener).to have_received(:update_success).with(post)
    end

    context 'when the update method fails' do
      let(:post) { instance_double(Post, update: false) }

      it 'notifies the listeners of the failure' do
        call
        expect(listener).to have_received(:update_failure).with(post)
      end
    end
  end
end
