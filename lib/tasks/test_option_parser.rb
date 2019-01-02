require 'byebug'
require 'optparse'

options = {}
output_format = nil
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("format=FORMAT") do |controller|
    puts "controller #{controller}"
    output_format = controller
  end
end.parse!

byebug
p options
p ARGV