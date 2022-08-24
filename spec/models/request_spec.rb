# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request, type: :model do
  context 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:following_id) }
    it { should_not validate_presence_of(:is_accepted) }
  end

  context 'associations' do
    it { should belong_to(:sender).class_name('User').with_foreign_key(:user_id) }
    it { should belong_to(:sending).class_name('User').with_foreign_key(:following_id) }
  end

  context 'column-specifications' do
    it { should have_db_column(:is_accepted).of_type(:boolean) }
    it { should have_db_column(:following_id).of_type(:integer) }
    it { should have_db_column(:user_id).of_type(:integer) }
  end
end
