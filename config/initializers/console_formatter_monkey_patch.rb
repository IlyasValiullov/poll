module ActionDispatch
  module Routing
    class ConsoleFormatter
      def initialize(format=nil)
        @buffer = []
        @format = format.present? && format.downcase ||'pvua'
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
        header_lengths = columns.map {|col| column_header(col)}.map(&:length)
        column_widths = widths(routes).zip(header_lengths).map(&:max)

        routes.map do |r|
          routes_values = columns.each_with_index.map do |col, index|
            # puts "align #{column_align(col)} - #{col}"
            r[column_value(col)].send(column_align(col),column_widths[index])
          end
          routes_values.join(' ')
        end
      end

      def draw_header(routes)
        # name_width, verb_width, path_width = widths(routes)
        #
        # "#{"Verb".rjust(verb_width)} #{"URI Pattern".ljust(path_width)} Controller#Action"

        column_widths = widths(routes)
        headers = columns.each_with_index.map do |column, index|
          # puts "align #{column_align(column)} - #{column}"
          column_header(column).send(column_align(column),column_widths[index])
        end
        headers.join(' ')
      end

      def widths(routes)
        columns.map do |column_name|
          routes.map {|r| r[column_value(column_name)].length}.max || 0
        end
      end

      def columns
        @format.split('')
      end

      def column_value(column)
        case column
        when 'p'
          :name
        when 'v'
          :verb
        when 'u'
          :path
        when 'a'
          :reqs
        end
      end

      def column_header(column)
        case column
        when 'p'
          "Prefix"
        when 'v'
          "Verb"
        when 'u'
          "URI Pattern"
        when 'a'
          "Controller#Action"
        end
      end

      def column_align(column)
        case column
        when 'p'
          :rjust
        when 'v', 'u', 'a'
          :ljust
        end
      end
    end
  end
end