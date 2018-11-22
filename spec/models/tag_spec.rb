require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { should belong_to(:item) }
  it { should validate_presence_of(:label) }
end
