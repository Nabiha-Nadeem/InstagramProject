# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Photo, type: :model do
  context 'column-specifications' do
    it { should have_db_column(:image).of_type(:string) }
    it { should have_db_column(:imageable_type).of_type(:string) }
    it { should have_db_column(:imageable_id).of_type(:integer) }
  end
end
