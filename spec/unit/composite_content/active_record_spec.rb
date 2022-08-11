# frozen_string_literal: true

RSpec.describe CompositeContent::ActiveRecord, type: :unit do
  context 'with any ActiveRecord model' do
    subject(:model) { Class.new(::ActiveRecord::Base) } # rubocop:disable Rails/ApplicationRecord

    it { is_expected.to respond_to(:has_composite_content) }
  end

  describe '.has_composite_content', type: :model do
    context 'without an explicit name' do
      subject(:model) { Article.new } # Model definition in dummy app

      it { is_expected.to have_one(:composite_content).class_name("Article::CompositeContentSlot").dependent(:destroy) }
      it { is_expected.to accept_nested_attributes_for(:composite_content) }

      describe "#composite_content" do
        it 'returns a CompositeContent::Slot' do
          expect(subject.composite_content).to be_a(CompositeContent::Slot)
        end
      end

      describe '.strong_parameters_for_composite_content' do
        it 'returns slot class strong parameters definition Hash' do
          expect(Article.strong_parameters_for_composite_content).to eq(Article::CompositeContentSlot.strong_parameters)
        end
      end
    end

    context 'with an explicit name' do
      subject(:model) { Page.new } # Model definition in dummy app

      it { is_expected.to have_one(:main).class_name("Page::MainSlot").dependent(:destroy) }
      it { is_expected.to accept_nested_attributes_for(:main) }

      describe "#main" do
        it 'returns a CompositeContent::Slot' do
          expect(subject.main).to be_a(CompositeContent::Slot)
        end
      end

      describe '.strong_parameters_for_main' do
        it 'returns slot class strong parameters definition Hash' do
          expect(Page.strong_parameters_for_main).to eq(Page::MainSlot.strong_parameters)
        end
      end

      it { is_expected.to have_one(:aside).class_name("Page::AsideSlot").dependent(:destroy) }
      it { is_expected.to accept_nested_attributes_for(:aside) }

      describe "#aside" do
        it 'returns a CompositeContent::Slot' do
          expect(subject.aside).to be_a(CompositeContent::Slot)
        end
      end

      describe '.strong_parameters_for_aside' do
        it 'returns slot class strong parameters definition Hash' do
          expect(Page.strong_parameters_for_aside).to eq(Page::AsideSlot.strong_parameters)
        end
      end
    end
  end
end
