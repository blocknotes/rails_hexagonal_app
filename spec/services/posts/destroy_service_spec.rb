# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::DestroyService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call(post: post) }

    let(:post) { instance_double(Post) }

    before { allow(post).to receive(:destroy) }

    it 'sends the destroy message to the post' do
      call
      expect(post).to have_received(:destroy).with(no_args)
    end
  end
end
