require 'thor'
require 'bandoleer/outfitter'

module Bandoleer
  class CLI < Thor
    desc 'craft ITEM', 'generates a generic bandoleer ruby file'
    def craft( const_name )
      Bandoleer::Outfitter.start [const_name]
    end
  end
end
