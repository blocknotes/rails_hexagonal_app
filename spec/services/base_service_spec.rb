# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaseService do
  subject(:base_service_class) { described_class }

  describe '.call' do
    let(:child_service_class) { Class.new(base_service_class) }
    let(:child_service_instance) { instance_double(ChildService, call: true) }

    before do
      stub_const('ChildService', child_service_class)
      allow(ChildService).to receive(:new).and_return(child_service_instance)
    end

    it 'sends the call message to a new instance' do
      ChildService.call
      expect(child_service_instance).to have_received(:call)
    end
  end
end
