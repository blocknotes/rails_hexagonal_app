# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::CreateService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call(attrs: attrs, listeners: [listener]) }

    let(:attrs) { { name: 'Some name' } }
    let(:listener) { double('SomeListener', create_failure: nil, create_success: nil) }
    let(:post) { instance_double(Post, save: true) }

    before do
      allow(Post).to receive(:new).and_return(post)
    end

    it 'creates a new instance and send the save message to the new post', :aggregate_failures do
      call
      expect(Post).to have_received(:new).with(attrs)
      expect(post).to have_received(:save).with(no_args)
      expect(listener).to have_received(:create_success).with(post)
    end

    context 'when the save method fails' do
      let(:post) { instance_double(Post, save: false) }

      it 'notifies the listeners of the failure' do
        call
        expect(listener).to have_received(:create_failure).with(post)
      end
    end
  end
end
