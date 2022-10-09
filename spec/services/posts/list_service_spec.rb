# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::ListService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call }

    let(:posts) do
      [instance_double(PostEntity), instance_double(PostEntity), instance_double(PostEntity)]
    end

    before { allow(PostsRepository).to receive(:list_posts_with_authors).and_return(posts) }

    it 'loads the posts' do
      call
      expect(PostsRepository).to have_received(:list_posts_with_authors)
    end
  end
end
