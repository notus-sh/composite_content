# frozen_string_literal: true

RSpec.describe CompositeContent::Blocks::Quote, type: :model do
  it { is_expected.to be_a_kind_of(CompositeContent::Model::Blockable) }

  it { is_expected.to have_db_column(:content).of_type(:text) }
  it { is_expected.to validate_presence_of(:content) }

  it { is_expected.to have_db_column(:source).of_type(:string) }
end
