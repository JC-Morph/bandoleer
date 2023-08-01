# frozen_string_literal: true

# Provides a method to convert snake_case Strings to CamelCase
module SnakeToCamel
  # Convert a String from snake_case to CamelCase
  # @param str [String] String to convert
  # @return [String]
  def snake_to_camel( str )
    str.split('_').map(&:capitalize).join
  end
end
