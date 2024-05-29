# frozen_string_literal: true

require_relative 'lib/processor'

if ARGV.length != 1
  puts 'Usage: bundle exec ruby main.rb <input_dir>'
  exit 1
end

input_dir = ARGV[0]
unless Dir.exist?(input_dir)
  puts "The directory #{input_dir} does not exist."
  exit 1
end

Processor.process(input_dir)
