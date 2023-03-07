# frozen_string_literal: true

RSpec.describe CompositeContent::Model::Builder::Slot, type: :unit do
  describe '.build' do
    subject(:klass) { described_class.build(parent, association) }

    before { CompositeContent::Model::Builder::Block.build(parent, association, types) }

    let(:association) { :composite_content }
    let(:parent) { dummy_model('Parent') }
    let(:types) { CompositeContent::Engine.config.block_types.dup.last(2) }

    it 'creates a subclass of CompositeContent::Slot' do
      expect(klass.new).to be_a(CompositeContent::Slot)
    end

    it 'namespaces class in its parent object namespace' do
      expect(klass.name).to start_with("#{parent.name}::")
    end

    it 'names class after association' do
      expect(klass.name).to end_with("::#{association.to_s.classify}Slot")
    end

    describe '.block_class' do
      it 'returns dedicated CompositeContent::Block class' do
        expect(klass.block_class.name).to eq('Parent::CompositeContentBlock')
      end
    end

    describe '.blockable_classes' do
      it 'returns allowed block types classes' do
        expect(klass.blockable_classes).to match_array(types.collect(&:constantize))
      end
    end

    describe '.strong_parameters' do
      it 'returns a strong parameters description' do
        expect(klass.strong_parameters).to include(:id, a_hash_including(:blocks_attributes))
      end

      it 'returns strong parameters description for CompositeContent::Block' do
        params = klass.strong_parameters.find { |e| e.is_a?(Hash) }
        expect(params[:blocks_attributes]).to include(:id, :position, :blockable_type, :_destroy)
      end

      it 'returns strong parameters description for allowed block types' do
        params = klass.strong_parameters.find { |e| e.is_a?(Hash) }
        expect(params[:blocks_attributes]).to include(a_hash_including(:blockable_attributes))
      end

      it 'returns strong parameters description only for allowed block types' do
        blocks_params = klass.strong_parameters.find { |e| e.is_a?(Hash) }
        blockable_params = blocks_params[:blocks_attributes].find { |e| e.is_a?(Hash) }
        expect(blockable_params[:blockable_attributes]).to contain_exactly(:id, :content, :source)
      end
    end

    describe 'created class', type: :model do
      subject(:slot) { klass.new }

      it { is_expected.to belong_to(:parent) }

      it do
        expect(slot).to have_many(:blocks)
          .class_name('Parent::CompositeContentBlock')
          .inverse_of(:slot)
          .dependent(:destroy)
      end

      it { is_expected.to accept_nested_attributes_for(:blocks) }

      it 'validates associated blocks' do
        slot.blocks.build(blockable: types.first.constantize.new)
        slot.validate

        expect(slot.errors.attribute_names).to include(match('blocks.blockable'))
      end
    end
  end
end
