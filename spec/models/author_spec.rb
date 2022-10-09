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
end
