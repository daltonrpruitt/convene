# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Membership, type: :model do
  subject(:membership) { build(:membership) }
  describe '#member' do
    it { is_expected.to belong_to(:member) }
    it { is_expected.to validate_uniqueness_of(:member).scoped_to(:space_id) }
  end

  describe '#space' do
    it { is_expected.to belong_to(:space) }
  end

  describe '#revoke' do
    it 'sets the status to revoked' do
      expect { membership.revoked! }.to change(membership, :status).from('active').to('revoked')
    end
  end
end
