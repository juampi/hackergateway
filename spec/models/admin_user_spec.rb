# frozen_string_literal: true

RSpec.describe AdminUser, type: :model do
  context "with valid parameters" do
    subject(:admin_user) { FactoryBot.build(:admin_user) }

    it { is_expected.to be_valid }
  end
end
