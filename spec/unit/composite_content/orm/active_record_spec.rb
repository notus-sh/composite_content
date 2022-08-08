# frozen_string_literal: true

require 'models/shared/block_container'
require 'models/shared/model_with_container'

RSpec.describe CompositeContent::ORM::ActiveRecord, type: :unit do
  context 'with any ActiveRecord model' do
    subject(:model) { Class.new(ActiveRecord::Base) } # rubocop:disable Rails/ApplicationRecord

    it { is_expected.to respond_to(:has_composite_content) }
    it { is_expected.to respond_to(:has_composite_content_slot) }
    it { is_expected.to respond_to(:has_composite_content_slots) }
  end

  describe '.has_composite_content' do
    subject(:model) { Article.new } # Model definition in dummy app

    it_behaves_like 'a block container'
  end

  describe '.has_composite_content_slot' do
    subject(:model) { Post.new } # Model definition in dummy app

    it_behaves_like 'a model with a block container', named: :content
  end

  describe '.has_composite_content_slots' do
    subject(:model) { Page.new } # Model definition in dummy app

    it_behaves_like 'a model with a block container', named: :main
    it_behaves_like 'a model with a block container', named: :aside
  end
end
