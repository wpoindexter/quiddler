require 'rails_helper'

RSpec.describe GameSerializer, type: :serializer do
  let(:resource) { FactoryGirl.build :active_game }
  let(:serializer) { GameSerializer.new resource }

  subject do
    JSON.parse(serializer.to_json).deep_symbolize_keys[:game]
  end

  it 'should have valid content' do
    expect(subject.keys).to eq [:id, :active, :friendly_name, :players]
  end

  it 'should contain a valid id' do
    expect(subject[:id]).to eq resource.id
  end
end
