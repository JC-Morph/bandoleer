# frozen_string_literal: true

require 'thor'
require 'bandoleer/outfitter'

module Bandoleer
  # Bandoleer command line interface.
  class CLI < Thor
    desc 'craft DIR', 'Generate a bandoleer file for the directory'
    # Generates a bandoleer file.
    # @param dir [String] directory to use
    def craft( dir )
      Bandoleer::Outfitter.start [dir]
    end
  end
end
