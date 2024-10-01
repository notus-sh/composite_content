# frozen_string_literal: true

module CompositeContent
  # Additional views helpers to manipulate composite content.
  module ActionView
    # Render the content of a CompositeContent::Slot.
    def composite_content_render(slot)
      renders = slot.blocks.collect do |block|
        render "#{CompositeContent::Engine.config.views_path}/blocks/#{block.blockable.block_type}/show", block: block
      end

      safe_join(renders)
    end

    # Output an action link to add a block to a slot.
    #
    # ==== Signatures
    #
    #   composite_content_add_block_link(label, form, block_type, options = {})
    #     # Explicit name
    #
    #   composite_content_add_block_link(form, block_type, options = {}) do
    #     # Name as a block
    #   end
    #
    #   composite_content_add_block_link(form, block_type, options = {})
    #     # Use default name
    #
    # ==== Parameters
    #
    # `label` is the text to be used as the link label.
    # Just as when you use the Rails builtin helper +link_to+, you can give an explicit
    # label to your link or use a block to build it. If you provide neither an explicit
    # label nor a  block, the default label will be used, looking for an I18n key named
    # `composite_content.blocks.{block type}.add`.
    #
    # `form` is your form builder. Can be a SimpleForm::Builder, Formtastic::Builder or
    # a standard Rails FormBuilder.
    #
    # `options` are passed to the cocooned_add_item_link helper, which some adjustements:
    # :count, :form_name, :force_non_association_create are ignored, :form_name, :partial
    # and :wrap_object are forced on purpose. Any other option will be passed.
    # See the documentation of cocooned_add_item_link for details.
    def composite_content_add_block_link(*args, &block)
      return composite_content_add_block_link(capture(&block), *args) if block
      return composite_content_add_block_link(nil, *args) if args.first.respond_to?(:object)

      label, form, block_type, options = *args
      label ||= composite_content_default_label(block_type)
      opts = (options || {}).except(:count, :form_name, :force_non_association_create)
                            .merge!(form_name: :form,
                                    partial: "#{CompositeContent::Engine.config.views_path}/block/form",
                                    wrap_object: ->(b) { composite_content_wrap_block(b, block_type) })

      cocooned_add_item_link(label, form, :blocks, opts)
    end

    # Alias to cocooned_move_item_up_link
    def composite_content_move_block_up_link(...)
      cocooned_move_item_up_link(...)
    end

    # Alias to cocooned_move_item_down_link
    def composite_content_move_block_down_link(...)
      cocooned_move_item_down_link(...)
    end

    # Alias to cocooned_remove_item_link
    def composite_content_remove_block_link(...)
      cocooned_remove_item_link(...)
    end

    protected

    def composite_content_default_label(block_type)
      I18n.t("composite_content.blocks.#{block_type}.add")
    end

    def composite_content_wrap_block(block, block_type)
      block.blockable = CompositeContent::Blocks.const_get(block_type.to_s.classify).new
      block
    end
  end
end
