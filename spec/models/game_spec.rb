require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'associations' do
    it { should have_many :players }
  end

  describe 'validations' do
    it { should validate_uniqueness_of :friendly_name }
    it { should validate_presence_of :friendly_name }
  end
end
