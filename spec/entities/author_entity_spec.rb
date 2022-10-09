# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthorEntity do
  let(:source_model) { Author.new(email: 'some@email.it', name: 'John', age: 20) }

  describe '#to_s' do
    subject(:author) { described_class.load(source_model) }

    it 'returns name and age' do
      expect(author.to_s).to eq 'John (20)'
    end
  end
end
