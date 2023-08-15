# frozen_string_literal: true

require 'thor/group'
require 'bandoleer/erb_helper'

module Bandoleer
  # Generator for bandoleer template files.
  class Outfitter < Thor::Group
    include Thor::Actions
    include ErbHelper
    attr_reader :const_arr, :content, :file_name, :vials

    argument :const_name, type: :string

    # Assign instance variables needed for crafting a fresh bandoleer.
    def prepare_materials
      @const_arr = const_name.split('/')
      @file_name = const_arr.last
      @const_arr.map! {|const| const.split('_').map(&:capitalize).join }
    end

    # Create and populate a bandoleer template file using assigned variables.
    def craft_bandoleer
      label_vials
      @content = erb_resolve('vials')
      wrap_content
      template '%file_name%.rb.tt'
    end

    private

    def label_vials
      files  = Dir.glob(File.join(file_name, '*.rb'))
      @vials = files.map do |file|
        "    #{File.basename(file, '.*')}"
      end.join("\n")
    end

    # Wrap the module content within interstitial modules, whilst maintaining
    # the correct indentation.
    def wrap_content
      const_arr[0..-2].reverse.each do |const|
        hsh = {const: const, content: indent_content}
        @content = erb_resolve('module', hsh)
      end
    end

    # return [String] indent @content by two spaces, except for empty lines
    def indent_content
      lines = content.split("\n")
      lines.map do |line|
        line.empty? ? line : line.prepend('  ')
      end.join("\n")
    end
  end
end
