require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should have_many(:tags).dependent(:destroy) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:date) }
end
