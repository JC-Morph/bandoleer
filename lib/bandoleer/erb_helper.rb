# frozen_string_literal: true

module Bandoleer
  # Provides a helper method for resolving erb templates.
  module ErbHelper
    # Add the method .source_root to klass when included.
    def self.included( base )
      base.define_singleton_method(:source_root) do
        File.join(__dir__, '/templates')
      end
    end

    # Retrieve an erb template and fill it. Uses an optional hash to provide
    # variables, otherwise uses a binding of the current context to access
    # any instance variables.
    # @return [String] the filled template
    def fill_erb_template( template_name, hsh = {} )
      erb = ERB.new source_template(template_name)
      return erb.result(get_binding) if hsh.empty?
      erb.result_with_hash hsh
    end

    private

    # @return [Binding] current context
    def get_binding
      binding
    end

    # @return [String] contents of a template file
    def source_template( name )
      File.read(File.join(self.class.source_root, "#{name}.tt"))
    end
  end
end
