# frozen_string_literal: true

require 'canister'
require 'forwardable'
require_relative 'bandoleer/snake_to_camel'

# Wrapper for Canister, a container gem used to register dependencies.
# Provides helper methods for referencing constants from files.
module Bandoleer
  extend Forwardable
  # @!method []( key )
  #   @param key [Symbol] key for the entry to resolve
  # @!method keys
  #   @return [Array] list of keys for registered entries
  def_delegators :pockets, :[], :keys, :method_missing
  alias equipped keys

  # Ensure vials are resolved when a module extending Bandoleer is included.
  # @param base the module that has extended Bandoleer
  def self.extended( base )
    base.define_singleton_method(:included) {|_base| label_vials }
  end

  # Resolve all of the registered entries in Canister at once.
  def label_vials
    equipped.each {|vial| bandoleer.resolve vial }
  end

  # @return [Canister] the stored Canister instance
  def pockets
    @pockets ||= Canister.new
  end

  # Register a single file or an Array of filenames.
  # Assumes that all files are ruby files inside a folder named Klass.name,
  # and that they all define a constant matching the name of the file.
  # @param files [String, Array] filename(s) to be registered
  def equip( files )
    [files].flatten.each do |vial|
      bandoleer.register(vial) do
        retrieve vial
        const_get snake_to_camel(vial.to_s)
      end
    end
  end

  # Register a Hash of filenames with custom actions.
  # @param elixirs [Hash] pairs of files with their associated lambda or value
  def equip_custom( elixirs )
    elixirs.each do |vial, contents|
      bandoleer.register(vial.downcase) do
        retrieve vial
        contents
      end
    end
  end

  private

  include SnakeToCamel

  # Explicitly requires given files, allowing Bandoleer to reference any defined
  # constants in the current context. Skips a file if the name matches an
  # already defined constant.
  def retrieve( files )
    [files].flatten.each do |file|
      file = file.to_s
      next if const_defined? snake_to_camel(file)
      require File.join(name.sub('::', File::SEPARATOR).downcase, file)
    end
  end
end
