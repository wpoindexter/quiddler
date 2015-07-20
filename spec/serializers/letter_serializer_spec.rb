require 'rails_helper'

RSpec.describe LetterSerializer, type: :serializer do
  let(:resource) { FactoryGirl.build :letter }
  let(:serializer) { LetterSerializer.new resource }

  subject do
    JSON.parse(serializer.to_json).deep_symbolize_keys[:letter]
  end

  it 'should have valid content' do
    expect(subject.keys).to eq [:text, :points]
  end

  it 'should contain a valid id' do
    expect(subject[:id]).to eq resource.id
  end
end
