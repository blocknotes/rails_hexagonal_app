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
end
