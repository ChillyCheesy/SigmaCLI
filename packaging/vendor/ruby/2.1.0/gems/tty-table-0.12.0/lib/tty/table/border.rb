# frozen_string_literal: true

require "pastel"
require "strings"

require_relative "border_dsl"
require_relative "border/row_line"
require_relative "error"

module TTY
  class Table
    # Abstract base class that is responsible for building the table border.
    class Border
      EMPTY_CHAR = ""

      SPACE_CHAR = " "

      # Represent a separtor on each row
      EACH_ROW = :each_row

      # specify a separator as a row
      SEPARATOR = :separator

      class << self
        # Store characters for border
        #
        # @api private
        attr_accessor :characters
      end

      # Define border characters
      #
      # @param [Hash] characters
      #   the border characters
      #
      # @return [Hash]
      #
      # @api public
      def self.def_border(characters = (not_set = true), &block)
        return self.characters = characters unless not_set

        dsl = BorderDSL.new(&block)
        self.characters = dsl.characters
      end

      # Instantiate a new object
      #
      # @param [Array] column_widths
      #   the table column widths
      #
      # @param [BorderOptions] border_opts
      #
      # @return [Object]
      #
      # @api private
      def initialize(column_widths, border_opts = nil)
        if self.class == Border
          raise NotImplementedError, "#{self} is an abstract class"
        end

        @widths = column_widths
        @dsl = BorderDSL.new(border_opts)
        @characters = self.class.characters.merge(@dsl.characters)
        @color = Pastel.new
      end

      # Retrive individual character by type
      #
      # @param [String] type
      #   the character type
      #
      # @return [String]
      #
      # @api private
      def [](type)
        @characters[type] || EMPTY_CHAR
      end

      # Check if border color is set
      #
      # @return [Boolean]
      #
      # @api public
      def color?
        !!@dsl.style
      end

      # A line spanning all columns marking top of a table.
      #
      # @return [String]
      #
      # @api private
      def top_line
        (result = render(:top)).empty? ? nil : result
      end

      # A line spannig all columns marking bottom of a table.
      #
      # @return [String]
      #
      # @api private
      def bottom_line
        (result = render(:bottom)).empty? ? nil : result
      end

      # A line spanning all columns delemeting rows in a table.
      #
      # @return [String]
      #
      # @api private
      def middle_line
        (result = render(:mid)).empty? ? nil : result
      end

      # A line spanning all columns delemeting fields in a row.
      #
      # @param [TTY::Table::Row] row
      #   the table row
      #
      # @return [String]
      #
      # @api public
      def row_line(row)
        line = RowLine.new(self["left"], self["center"], self["right"])
        line.colorize(self, @dsl.style) if color?

        result = row_heights(row, line)
        result.empty? ? EMPTY_CHAR : result
      end

      # Set color for a string
      #
      # @param [Symbol] color
      #
      # @param [String] string
      #   the string to color
      #
      # @return [String]
      #
      # @api public
      def set_color(color, string)
        return string if string.gsub(/\s+/, EMPTY_CHAR).empty?

        @color.decorate(string, color)
      end

      protected

      # The row field widths
      #
      # @api private
      attr_reader :widths

      # The table custom border options including styling
      #
      # @api private
      def border_options
        @dsl.options
      end

      # Separate multiline string into individual rows with border.
      #
      # @param [TTY::Table::Row] row
      #   the table row
      #
      # @param [TTY::Table::Border::RowLine] line
      #
      # @api private
      def row_heights(row, line)
        if row.size > 0
          row.height.times.map do |line_index|
            row_height_line(row, line_index, line)
          end.join("\n")
        else
          line.left + line.right
        end
      end

      # Generate border for a given multiline row
      #
      # @param [TTY::Table::Row] row
      #   the table row
      #
      # @param [Integer] line_index
      #  the index for current line inside multiline
      #
      # @param [TTY::Table::Border::RowLine] line
      #
      # @return [String]
      #
      # @api private
      def row_height_line(row, line_index, line)
        line.left + row.fields.each_with_index.map do |field, index|
          direction     = field.alignment || :left
          field_content = field.lines[line_index] || SPACE_CHAR * field.length
          Strings.align(field_content, widths[index], direction: direction)
        end.join(line.center) + line.right
      end

      # Generate particular border type
      #
      # @param [String] type
      #  border type one of :top, :bottom and :mid
      #
      # @return [String]
      #
      # @api private
      def render(type)
        type = type.to_s
        border_char = self[type]
        line = render_line(border_char,
                           self["#{type}_left"]  || border_char,
                           self["#{type}_right"] || border_char,
                           self["#{type}_mid"])

        return line unless color?

        set_color(@dsl.style, line)
      end

      # Generate a border string
      #
      # @param [String] line
      #   the line character
      #
      # @return [String]
      #
      # @api private
      def render_line(line, left, right, intersection)
        left + widths.map { |width| line * width }.join(intersection) + right
      end
    end # Border
  end # Table
end # TTY
