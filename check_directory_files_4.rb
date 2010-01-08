#!/usr/bin/env ruby

require 'optparse'

# Parse command line parameters
# Parse command line parameters

def parse_opts(options)
  # Setup OptionParser and specify available parameters
  opts = OptionParser.new do |opts|
    opts.banner = "Usage: check_directory_files_1 [options]"

    opts.on("-h", "--help", 'Display this message') do
      puts opts
      exit
    end

    opts.on("-d X", "--directory X", String, "directory to check") do |dir|
      options[:dir] = dir
    end

    # specify default value for a parameter.  This will be used unless the user specifies something else
    options[:critical] = 15000
    opts.on("-c #", "--critical #", Integer, "critical level") do |critical|
      options[:critical] = critical
    end

    opts.on("-w #", "--warning #", Integer, "warning level" ) do |warning|
      options[:warning] = warning
    end
  end

  # Actually parse the parameters
  opts.parse!(ARGV)

  # make sure all the parameters that are required actually exist
  raise OptionParser::MissingArgument if options[:dir].nil?
  raise OptionParser::MissingArgument if options[:critical].nil?
  raise OptionParser::MissingArgument if options[:warning].nil?
end

options = {}

parse_opts(options)

path = options[:dir]

puts "Checking Directory #{path}"

# Actually count files in directory
count = `ls -al #{path}| wc -l`.lstrip.chomp.to_i


# Print out results
if count >= options[:critical]
  puts "Critical Error: #{count} files in #{path}"
elsif count >= options[:warning]
  puts "Warning: #{count} files in #{path}"
else
  puts "OK: #{count} files in #{path}"
end
