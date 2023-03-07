# frozen_string_literal: true

RSpec.describe CompositeContent::Blocks::Text, type: :model do
  it { is_expected.to be_a(CompositeContent::Model::Blockable) }

  it { is_expected.to have_db_column(:content).of_type(:text) }
  it { is_expected.to validate_presence_of(:content) }
end
