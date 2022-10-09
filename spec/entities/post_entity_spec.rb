# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostEntity do
  describe '#short_title' do
    subject(:post) { described_class.load(source_model) }

    let(:source_model) { Post.new(title: 'Some looooooooooooong title') }

    it 'returns a shorter title' do
      expect(post.short_title).to eq 'Some lo...'
    end
  end

  describe '#tags_list' do
    subject(:post) { described_class.load(source_model, with_relations: true) }

    let(:source_model) { Post.new(title: 'A title', tags: tags) }
    let(:tags) { [Tag.new(name: '1st tag'), Tag.new(name: '2nd tag')] }

    it 'returns the tag names' do
      expect(post.tags_list).to eq '1st tag, 2nd tag'
    end
  end

  describe '#upper_title' do
    subject(:post) { described_class.load(source_model) }

    let(:source_model) { Post.new(title: 'Some title') }

    it 'returns the title upper case' do
      expect(post.upper_title).to eq 'SOME TITLE'
    end
  end
end
