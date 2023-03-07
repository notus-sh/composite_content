# frozen_string_literal: true

require 'unit/shared/model_with_composite_content'

RSpec.describe CompositeContent::ActiveRecord, type: :unit do
  context 'with any ActiveRecord model' do
    subject(:model) { Class.new(ApplicationRecord) }

    it { is_expected.to respond_to(:has_composite_content) }
  end

  describe '.has_composite_content' do
    context 'without an explicit name' do
      subject(:model) { Article.new } # Model definition in dummy app

      it_behaves_like 'a model with composite content', Article
    end

    context 'with an explicit name' do
      subject(:model) { Page.new } # Model definition in dummy app

      it_behaves_like 'a model with composite content', Page, :main
      it_behaves_like 'a model with composite content', Page, :aside
    end
  end
end
