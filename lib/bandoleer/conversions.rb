# frozen_string_literal: true

# Provides methods to convert various objects to usefully formatted Strings
module Bandoleer
  module Conversions
    # Convert a String from snake_case to CamelCase
    # @param str [String] String to convert
    # @return [String]
    def snake_to_camel( str )
      str.split('_').map(&:capitalize).join
    end

    # Convert the klass name to a snake_cased String
    # @return [String]
    def klass_to_snake
      name.split('::').last.split(/(?=[A-Z])/).join('_').downcase
    end
  end
end
