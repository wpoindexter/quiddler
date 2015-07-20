require 'rails_helper'

RSpec.describe PlayerSerializer, type: :serializer do
  let(:resource) { FactoryGirl.build :player }
  let(:serializer) { PlayerSerializer.new resource }

  subject do
    JSON.parse(serializer.to_json).deep_symbolize_keys[:player]
  end

  it 'should have valid content' do
    expect(subject.keys).to eq [:id, :name, :scorekeeper]
  end

  it 'should contain a valid id' do
    expect(subject[:id]).to eq resource.id
  end
end
