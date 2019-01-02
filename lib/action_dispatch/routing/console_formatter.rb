module ActionDispatch
  module Routing
    class ConsoleFormatter
      def initialize(format="PVUA")
        @buffer = []
        @format = format
      end

      def result
        @buffer.join("\n")
      end

      def section_title(title)
        @buffer << "\n#{title}:"
      end

      def section(routes)
        @buffer << draw_section(routes)
      end

      def header(routes)
        @buffer << draw_header(routes)
      end

      def no_routes(routes)
        @buffer <<
            if routes.none?
              <<-MESSAGE.strip_heredoc
          You don't have any routes defined!

          Please add some routes in config/routes.rb.
              MESSAGE
            else
              "No routes were found for this controller"
            end
        @buffer << "For more information about routes, see the Rails guide: http://guides.rubyonrails.org/routing.html."
      end

      private
      def draw_section(routes)
        header_lengths = ["Prefix", "Verb", "URI Pattern"].map(&:length)
        name_width, verb_width, path_width = widths(routes).zip(header_lengths).map(&:max)

        # routes.map do |r|
        #   "#{r[:name].rjust(name_width)} #{r[:verb].ljust(verb_width)} #{r[:path].ljust(path_width)} #{r[:reqs]}"
        # end

        routes.map do |r|
          "#{r[:verb].rjust(verb_width)} #{r[:path].ljust(path_width)} #{r[:reqs]}"
        end
      end

      def draw_header(routes)
        name_width, verb_width, path_width = widths(routes)

        "#{"Verb".rjust(verb_width)} #{"URI Pattern".ljust(path_width)} Controller#Action"
      end

      def widths(routes)
        [routes.map { |r| r[:name].length }.max || 0,
         routes.map { |r| r[:verb].length }.max || 0,
         routes.map { |r| r[:path].length }.max || 0]
      end


    end
  end
end