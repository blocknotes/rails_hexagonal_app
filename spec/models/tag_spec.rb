# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'validations' do
    it { is_expected.not_to be_valid }

    context 'with a name' do
      subject(:tag) { described_class.new(name: 'A tag') }

      it { is_expected.to be_valid }
    end
  end
end
