# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adapters::CSVWriterService do
  subject(:service_class) { described_class }

  describe '.call' do
    subject(:call) { service_class.call(columns: columns, rows: rows) }

    context 'with empty columns and rows' do
      let(:columns) { [] }
      let(:rows) { [] }

      it 'generates the expected CSV data' do
        expect(call).to eq "\n"
      end
    end

    context 'with some columns but empty rows' do
      let(:columns) { ['Col 1', 'Col 2', 'Col 3'] }
      let(:rows) { [] }

      it 'generates the expected CSV data' do
        expect(call).to eq "Col 1,Col 2,Col 3\n"
      end
    end

    context 'with some columns and rows' do
      let(:columns) { ['Col 1', 'Col 2', 'Col 3'] }
      let(:rows) do
        [
          ['Cell A1', 'Cell B1', 'Cell C1'],
          ['Cell A2', 'Cell B2', 'Cell C2'],
          ['Cell A3', 'Cell B3', 'Cell C3']
        ]
      end

      it 'generates the expected CSV data' do
        expect(call).to eq <<~CSV
          Col 1,Col 2,Col 3
          Cell A1,Cell B1,Cell C1
          Cell A2,Cell B2,Cell C2
          Cell A3,Cell B3,Cell C3
        CSV
      end
    end
  end
end
