# frozen_string_literal: true

RSpec.describe CompositeContent::Model::Builder::Block, type: :unit do
  describe '.build' do
    subject(:klass) { described_class.build(parent, association, types) }

    before { CompositeContent::Model::Builder::Slot.build(parent, association) }

    let(:association) { :composite_content }
    let(:parent) { dummy_model('Parent') }
    let(:types) { CompositeContent::Engine.config.block_types.dup.sample(2) }

    it 'creates a subclass of CompositeContent::Block' do
      expect(klass.new).to be_a(CompositeContent::Block)
    end

    it 'namespaces class in its parent object namespace' do
      expect(klass.name).to start_with("#{parent.name}::")
    end

    it 'names class after association' do
      expect(klass.name).to end_with("::#{association.to_s.classify}Block")
    end

    describe 'created class', type: :model do
      subject(:block) { klass.new }

      it { is_expected.to belong_to(:slot).inverse_of(:blocks).class_name('Parent::CompositeContentSlot') }
      it { is_expected.to belong_to(:blockable).dependent(:destroy) }
      it { is_expected.to accept_nested_attributes_for(:blockable) }

      it 'validates blockable is of one of the allowed types' do
        wrong_type = (CompositeContent::Engine.config.block_types - types).first
        block.blockable = wrong_type.constantize.new

        expect(block).not_to be_valid
      end

      it 'validates associated blockable' do
        block.blockable = types.first.constantize.new
        block.validate

        expect(block.errors.attribute_names).to include(match('blockable.'))
      end
    end
  end
end
