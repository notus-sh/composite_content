# frozen_string_literal: true

require 'models/shared/block_container'

RSpec.describe CompositeContent::Slot, type: :model do
  it_behaves_like 'a block container'

  it { is_expected.to belong_to(:parent) }
end
