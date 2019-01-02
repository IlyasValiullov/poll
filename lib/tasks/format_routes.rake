# frozen_string_literal: true
require 'byebug'
require "optparse"

desc "Print out all defined routes in match order, with names. Target specific controller with -c option, or grep routes using -g option. -f option define format of output routes - available values - V(verb), P(prefix), U(uri), A(action)"
task froutes: :environment do
  all_routes = Rails.application.routes.routes
  require "action_dispatch/routing/inspector"
  inspector = ActionDispatch::Routing::RoutesInspector.new(all_routes)

  routes_filter = nil
  output_format = ENV['format']

  OptionParser.new do |opts|
    opts.banner = "Usage: rails routes [options]"

    Rake.application.standard_rake_options.each { |args| opts.on(*args) }

    opts.on("-c CONTROLLER") do |controller|
      routes_filter = { controller: controller }
    end

    opts.on("-g PATTERN") do |pattern|
      routes_filter = pattern
    end

    # opts.on("-q FORMAT") do |format|
    #   output_format = format
    # end
    #
  end.parse!(ARGV.reject { |x| x == "froutes" })

  puts inspector.format(ActionDispatch::Routing::ConsoleFormatter.new(output_format), routes_filter)

  exit 0 # ensure extra arguments aren't interpreted as Rake tasks
end