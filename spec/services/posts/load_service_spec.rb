# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::LoadService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call(post.id) }

    let(:post) { double(PostEntity, id: 123) }

    before { allow(PostsRepository).to receive(:find).and_return(post) }

    it 'loads the post' do
      expect(call).to eq post
    end
  end
end
