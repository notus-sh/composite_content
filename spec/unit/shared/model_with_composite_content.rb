# frozen_string_literal: true

RSpec.shared_examples 'a model with composite content', type: :model do |parent, association = :composite_content|
  classname = "#{parent.model_name}::#{association.to_s.classify}Slot"

  it { is_expected.to have_one(association).class_name(classname).dependent(:destroy) }
  it { is_expected.to accept_nested_attributes_for(association) }

  describe "##{association}" do
    it 'returns a CompositeContent::Slot' do
      expect(subject.send(association)).to be_a(CompositeContent::Slot)
    end
  end

  describe ".strong_parameters_for_#{association}" do
    it 'returns slot class strong parameters definition Hash' do
      expect(parent.send(:"strong_parameters_for_#{association}")).to eq(classname.constantize.strong_parameters)
    end
  end
end
