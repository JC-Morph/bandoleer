Feature: Generating bandoleer specs

	The bandoleer CLI should be able to predictably generate a basic
	implementation of a bandoleer module that populates itself with the ruby
	files from the directory of the same name passed to the CLI.

	Background:
		Given a file named "basic_bandoleer/basic_ruby.rb" with:
		"""
		module BasicRuby
		end
		"""

	Scenario: Empty spec
		When I run `bandoleer craft gen`
		Then the file "gen.rb" should exist
		Then the file "gen.rb" should contain:
		"""
		require 'bandoleer'

		module Gen
		  extend Bandoleer

		  vials = %i[

		  ]

		  equip vials
		end
		"""

	Scenario: Populated spec
		When I run `bandoleer craft basic_bandoleer`
		Then the file "basic_bandoleer.rb" should exist
		Then the file "basic_bandoleer.rb" should contain:
		"""
		require 'bandoleer'

		module BasicBandoleer
		  extend Bandoleer

		  vials = %i[
		    basic_ruby
		  ]

		  equip vials
		end
		"""

	Scenario: Nested module
		When I run `bandoleer craft nested_module/basic_bandoleer`
		Then the file "basic_bandoleer.rb" should exist
		Then the file "basic_bandoleer.rb" should contain:
		"""
		require 'bandoleer'

		module NestedModule
		  module BasicBandoleer
		    extend Bandoleer

		    vials = %i[
		      basic_ruby
		    ]

		    equip vials
		  end
		end
		"""
