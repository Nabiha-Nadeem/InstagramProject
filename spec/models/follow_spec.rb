# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follow, type: :model do
  context 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:following_id) }
  end

  context 'associations' do
    it { should belong_to(:follower).class_name('User').with_foreign_key(:user_id) }
    it { should belong_to(:following).class_name('User').with_foreign_key(:following_id) }
  end

  context 'column-specifications' do
    it { should have_db_column(:following_id).of_type(:integer) }
    it { should have_db_column(:user_id).of_type(:integer) }
  end
end
