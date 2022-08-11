# frozen_string_literal: true

module CompositeContent
  module Generators
    # Generator to copy CompositeContent views into an application.
    class InstallGenerator < Rails::Generators::Base
      desc 'Copies composite_content partial templates to your application.'

      source_root File.expand_path('templates', __dir__)

      def copy_views
        directory File.join(self.class.source_root), 'app/views/composite_content'
      end

      def copy_migrations
        rake 'composite_content:install:migrations'
      end
    end
  end
end
