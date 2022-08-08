# frozen_string_literal: true

RSpec.shared_examples 'a model with a block container', type: :model do |options = {}|
  name = options.fetch(:named)

  it do
    expect(subject).to have_one(name)
      .conditions(name: name)
      .class_name(CompositeContent::Slot.name)
      .dependent(:destroy)
  end

  it { is_expected.to accept_nested_attributes_for(name) }

  describe "##{name}" do
    it 'returns a CompositeContent::Slot' do
      expect(subject.send(name)).to be_a(CompositeContent::Slot)
    end
  end
end
