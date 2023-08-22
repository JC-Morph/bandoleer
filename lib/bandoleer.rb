# frozen_string_literal: true

require 'canister'
require 'forwardable'
require_relative 'bandoleer/conversions'

# Wrapper for Canister, a container gem used to register dependencies.
# Provides helper methods for referencing constants from files.
module Bandoleer
  extend Forwardable
  # @!method []( key )
  #   Resolve a registered entry from Canister.
  #   @param key [Symbol] key for the entry to resolve
  # @!method keys
  #   @return [Array] list of keys for registered entries
  def_delegators :pockets, :[], :keys, :method_missing
  alias equipped keys

  # Ensure vials are resolved when a module extending Bandoleer is included.
  # @param base [Module] the module that has extended Bandoleer
  def self.extended( base )
    base_dir = File.dirname(const_source_location(base.name).first)
    base.instance_variable_set(:@klass_dir, base_dir)
    base.define_singleton_method(:included) {|_base| open_vials }
  end

  # Resolve all of the registered entries at once.
  def open_vials
    equipped.each {|vial| pockets.resolve vial }
  end

  # @return [Canister] the stored Canister instance
  def pockets
    @pockets ||= Canister.new
  end

  # Register a single file or an Array of filenames.
  # Assumes that all files are ruby files inside a folder named Klass.name,
  # and that they all define a constant matching the name of the file.
  # @param files [String, Symbol, Array] filename(s) to be registered
  def equip( files )
    [files].flatten.each do |vial|
      pockets.register(vial) do
        retrieve vial
        const_get snake_to_camel(vial.to_s)
      end
    end
  end

  # Register a Hash of filenames with custom actions.
  # @param elixirs [Hash] file keys with their associated values
  def equip_custom( elixirs )
    elixirs.each do |vial, contents|
      pockets.register(vial.downcase) do
        retrieve vial
        contents
      end
    end
  end

  private

  include Conversions

  # Explicitly requires given files, allowing Bandoleer to reference any defined
  # constants in the current context. Skips a file if the camelised name matches
  # an already defined constant.
  def retrieve( files )
    [files].flatten.each do |file|
      file = file.to_s
      next if const_defined? snake_to_camel(file)
      require File.join(@klass_dir, klass_to_snake, file)
    end
  end
end
