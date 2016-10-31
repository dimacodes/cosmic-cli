require_relative '../bin/environment.rb'

class AsciiArt

  def self.generate(src:, color: true, width: 75, indent_depth: 6, border: false)
    ascii = AsciiArt.new(src).to_ascii_art(color: color, width: width)
    ascii = remove_border(ascii)
    ascii = create_indent(ascii: ascii, indent_depth: indent_depth)
    ascii
  end

  def self.remove_border(ascii)
    ascii.gsub(/\|\n/, "\n").gsub(/\n\|/, "\n").gsub(/\+-+\+/, "\n")
  end

  def self.create_indent(ascii:, indent_depth:)
    ascii.gsub(/\n/, "\n#{"\t" * indent_depth}")
  end
end
