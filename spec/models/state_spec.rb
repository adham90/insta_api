require 'rails_helper'

RSpec.describe State, type: :model do

  context 'relations' do
    it { is_expected.to belong_to :bug }
  end
end
