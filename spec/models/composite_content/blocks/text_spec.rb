# frozen_string_literal: true

require 'models/shared/block_implementation'

RSpec.describe CompositeContent::Blocks::Text, type: :model do
  it_behaves_like 'a block implementation'

  it { is_expected.to have_db_column(:content).of_type(:text) }
  it { is_expected.to validate_presence_of(:content) }
end
