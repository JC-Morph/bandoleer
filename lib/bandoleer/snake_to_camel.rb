# frozen_string_literal: true

# Public: Converts str from snake_case to CamelCase.
#
# Returns String.
module SnakeToCamel
  def snake_to_camel( str )
    str.split('_').map(&:capitalize).join
  end
end
