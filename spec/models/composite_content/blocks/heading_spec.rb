# frozen_string_literal: true

require 'models/shared/block_implementation'

RSpec.describe CompositeContent::Blocks::Heading, type: :model do
  it_behaves_like 'a block implementation'

  it { is_expected.to have_db_column(:content).of_type(:string) }
  it { is_expected.to validate_presence_of(:content) }

  it { is_expected.to have_db_column(:level).of_type(:integer) }
  it { is_expected.to validate_presence_of(:level) }

  # rubocop:disable RSpec/ImplicitSubject
  it do
    is_expected.to validate_numericality_of(:level)
      .is_greater_than_or_equal_to(1)
      .is_less_than_or_equal_to(6)
      .only_integer
  end
  # rubocop:enable RSpec/ImplicitSubject
end
