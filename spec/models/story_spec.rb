# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Story, type: :model do
  context 'validations' do
    it { should validate_presence_of(:user_id) }
  end

  context 'associations' do
    it { should belong_to(:user).class_name('User') }
    it { should have_many(:photos).dependent(:destroy) }
  end

  context 'column-specifications' do
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_index(:user_id) }
  end
end
