require 'rails_helper'

RSpec.describe Bug, type: :model do
  context 'relations' do
    it { is_expected.to have_many :states }
  end

  context 'validations' do
    it { is_expected.to validate_uniqueness_of(:number).scoped_to(:application_token).case_insensitive }
  end

  context 'number count' do
    it 'increment the number scoped by application_token' do
      app_a_bug = create(:bug, application_token: 1)
      app_b_bug = create(:bug, application_token: 2)
      app_b2_bug = create(:bug, application_token: 2)

      expect(app_a_bug.number).to eql('1')
      expect(app_b2_bug.number).to eql('2')
    end
  end
end
