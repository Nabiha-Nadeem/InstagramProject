# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = create :user
  end

  context 'validations' do
    it { should validate_presence_of(:fullname) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity}
    it { expect(:is_private).to_not eql(nil)}
    it { should_not validate_presence_of(:bio) }
    it { expect(:fullname).to match(/\A[a-zA-Z.']+(?: [a-zA-Z.']+){0,4}\z/)}
  end

  context 'associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:stories).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }

    it { should have_many(:follows).dependent(:destroy) }
    it { should have_many(:follower_relationships).with_foreign_key(:following_id).class_name('Follow') }
    it { should have_many(:followers).through(:follower_relationships) }
    it { should have_many(:following_relationships).with_foreign_key(:user_id).class_name('Follow') }
    it { should have_many(:following).through(:following_relationships) }

    it { should have_many(:requests).dependent(:destroy) }
    it { should have_many(:sender_relationships).with_foreign_key(:following_id).class_name('Request') }
    it { should have_many(:senders).through(:sender_relationships) }
    it { should have_many(:sending_relationships).with_foreign_key(:user_id).class_name('Request') }
    it { should have_many(:sending).through(:sending_relationships) }

    it { should have_one_attached(:avatar) }
  end

  context 'column-specifications' do
    it { should have_db_column(:fullname).of_type(:string) }
    it { should have_db_column(:bio).of_type(:text) }
    it { should have_db_column(:is_private).of_type(:boolean) }
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_index(:email) }
  end

  context 'callbacks' do
    it 'adds default avatar after creation' do
      @user = create :user
      expect(@user.avatar).to be_valid
    end
  end
end
