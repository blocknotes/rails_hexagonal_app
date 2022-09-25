# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { is_expected.not_to be_valid }

    context 'with author and title' do
      subject(:post) { described_class.new(title: 'Some title', author: author) }

      let(:author) { Author.new(email: 'some@email.it') }

      it { is_expected.to be_valid }
    end
  end

  describe '#short_title' do
    subject(:post) { described_class.new(title: 'Some looooooooooooong title') }

    it 'returns a shorter title' do
      expect(post.short_title).to eq 'Some lo...'
    end
  end

  describe '#tags_list' do
    subject(:post) { described_class.new(title: 'A title', tags: tags) }

    let(:tags) { [Tag.new(name: '1st tag'), Tag.new(name: '2nd tag')] }

    it 'returns the tag names' do
      expect(post.tags_list).to eq '1st tag, 2nd tag'
    end
  end

  describe '#upper_title' do
    subject(:post) { described_class.new(title: 'Some title') }

    it 'returns the title upper case' do
      expect(post.upper_title).to eq 'SOME TITLE'
    end
  end
end
