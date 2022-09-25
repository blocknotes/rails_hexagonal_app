# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Author, type: :model do
  describe 'validations' do
    it { is_expected.not_to be_valid }

    context 'with an email' do
      subject(:author) { described_class.new(email: 'some@email.it') }

      it { is_expected.to be_valid }
    end
  end

  describe '#to_s' do
    subject(:author) { described_class.new(email: 'some@email.it', name: 'John', age: 20) }

    it 'returns name and age' do
      expect(author.to_s).to eq 'John (20)'
    end
  end
end
