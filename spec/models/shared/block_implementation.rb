# frozen_string_literal: true

RSpec.shared_examples 'a block implementation' do
  it { is_expected.to have_one(:block)  }
end
