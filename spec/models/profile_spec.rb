# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'validations' do
    it { is_expected.not_to be_valid }

    context 'with an author' do
      subject(:profile) { described_class.new(author: author) }

      let(:author) { Author.new(email: 'some@email.it') }

      it { is_expected.to be_valid }
    end
  end
end
