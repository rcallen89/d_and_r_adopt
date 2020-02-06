require 'rails_helper'

RSpec.describe PetAdoptForm, type: :model do
  describe 'relationships' do
    it { should belong_to :pet }
    it { should belong_to :adopt_form }
  end
end