require 'rails_helper'

RSpec.describe Letter, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of :text }
  end
end
