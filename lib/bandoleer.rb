# frozen_string_literal: true

require 'canister'
require 'forwardable'
require_relative 'bandoleer/snake_to_camel'

# Public: Wrapper for Canister, a container gem used to register dependencies.
# Provides helper methods for referencing constants from files.
module Bandoleer
  extend Forwardable
  def_delegators :bandoleer, :[], :method_missing

  # Private: Ensure vials are resolved when the Bandoleer is included.
  def self.extended( base )
    base.define_singleton_method(:included) {|_base| label_vials }
  end

  # Public: Resolve all of the registered entries in Canister at once.
  def label_vials
    equipped.each {|vial| bandoleer.resolve vial }
  end

  # Public: Return Array of registered entries.
  def equipped
    bandoleer.keys
  end

  # Public: Return or instantiate a Canister instance.
  def bandoleer
    @bandoleer ||= Canister.new
  end

  # Public: Register a single file or an Array of filenames. Assumes that
  # all files are ruby files inside a folder that matches Class.name, and that
  # contain a constant with the same name as the file.
  def equip( files )
    [files].flatten.each do |vial|
      bandoleer.register(vial) do
        retrieve vial
        const_get snake_to_camel(vial.to_s)
      end
    end
  end

  # Public: Register a Hash of filenames with custom actions.
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

  # Internal: Explicitly requires given files, allowing Bandoleer to reference
  # any defined constants in the current context. Skips input if it directly
  # matches an already defined constant.
  def retrieve( files )
    [files].flatten.each do |file|
      file = file.to_s
      next if const_defined? snake_to_camel(file)
      require File.join(name.sub('::', File::SEPARATOR).downcase, file)
    end
  end
end
