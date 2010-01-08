#!/usr/bin/ruby

# =============================================================================
# check_directory_files.rb
#
# This file is released into the public domain with no warranties whatsoever, 
# express or implied.
#
# You are free to use it however you dare!
# =============================================================================


# ####################################################################
#
# Initial script
# Potential problems:
#   Parameter parsing is non-standard, and just a little fragile
#   File counting loop works, but there may be better ways to do it
#   Minor logic error in the output section
#
# ####################################################################

if ARGV.count < 1
 puts "Usage: check_directory_files.rb -d \"dirname\" -c \"critical\" -w \"warning\""
 exit
end

d = ARGV.index("-d")
w = ARGV.index("-w")
c = ARGV.index("-c")

dirname = ARGV[d + 1]
warning = ARGV[w + 1]
critical = ARGV[c + 1]

critical = critical.to_i
warning = warning.to_i

puts "Checking Directory #{dirname}..."

files = Dir.entries(dirname)

count = 0

files.each do |file|
 if File.file?(dirname + "/" + file)
   count = count + 1
 end
end

if count >= critical
 puts "Critical Error: #{count} files in directory"
elsif count >= warning && count < critical
 puts "Warning Message: #{count} files in directory"
else
 puts "OK: #{count} files in directory"
end
