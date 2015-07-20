require 'rails_helper'

RSpec.describe WordSerializer, type: :serializer do
  let(:resource) { FactoryGirl.build :word }
  let(:serializer) { WordSerializer.new resource }

  before :each do
    ('a'..'z').each { |letter| Letter.create(text: letter, points: 1) }
  end

  subject do
    JSON.parse(serializer.to_json).deep_symbolize_keys[:word]
  end

  it 'should have valid content' do
    expect(subject.keys).to eq [:id, :text, :points]
  end

  it 'should contain a valid id' do
    expect(subject[:id]).to eq resource.id
  end
end
