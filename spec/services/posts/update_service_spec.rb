# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::UpdateService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call(post: post, attrs: attrs) }

    let(:post) { instance_double(Post) }
    let(:attrs) { { name: 'Some name' } }

    before { allow(post).to receive_messages(assign_attributes: true, save: true) }

    it 'sends the assign_attributes and save messages to the post', :aggregate_failures do
      call
      expect(post).to have_received(:assign_attributes).with(attrs)
      expect(post).to have_received(:save).with(no_args)
    end
  end
end
