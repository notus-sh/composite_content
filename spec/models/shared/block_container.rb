# frozen_string_literal: true

RSpec.shared_examples 'a block container', type: :model do
  it do
    expect(subject).to have_many(:blocks)
      .order(position: :asc)
      .class_name(CompositeContent::Block.name)
      .dependent(:destroy)
  end

  it do
    expect(subject).to accept_nested_attributes_for(:blocks)
      .allow_destroy(true)
  end
end
