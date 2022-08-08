# frozen_string_literal: true

RSpec.describe CompositeContent::Block, type: :model do
  it { is_expected.to belong_to(:parent) }

  it { is_expected.to belong_to(:blockable).dependent(:destroy) }
  it { is_expected.to accept_nested_attributes_for(:blockable) }

  it { is_expected.to have_db_column(:position).of_type(:integer) }
end
