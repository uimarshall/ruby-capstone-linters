require 'colorize'

class StyleGuides
  attr_reader :arr

  def initialize(arr)
    @arr = arr
    @opening_brace = 0
    @closing_brace = 0
  end

  def triple_equality?(line, error_line)
    return false unless /(?<!=)==(?!=)/.match(line)

    puts 'WARNING: '.yellow + "Expected triple equality on line: #{error_line}, " if /(?<!=)==(?!=)/.match(line)
    true
  end

  def case_sensitive?(line, error_line)
    return false unless /[A-Z]([A-Z0-9]*[a-z][a-z0-9]*[A-Z]|[a-z0-9]*[A-Z][A-Z0-9]*[a-z])[A-Za-z0-9]*/.match(line)

    if /^[A-Z]/.match(line)
      puts 'WARNING: '.yellow + "camelCase is recommended for variable names on line: #{error_line}, "
    end
    true
  end

  def trailing_spaces?(line, error_line)
    return false unless /.+[\w]\s\s.+/.match(line)

    puts 'ERROR: '.red + "Unexpected double spaces on line: #{error_line}."
    true
  end

  def underscore_in_names?(line, error_line)
    return false unless /_/.match(line)

    puts 'WARNING: '.yellow + "Unexpected  underscore in names on line: #{error_line}, use camelCase."
    true
  end

  def space_end_of_line?(line, error_line)
    return false unless /\s$/.match(line)

    puts 'ERROR: '.red + "Unexpected spaces at the end of the line,  line: #{error_line}."
    true
  end

  def missing_semicolon?(line, error_line)
    return false unless /^[^\n|\}|function](?:(?!;).)*$/.match(line)

    puts 'ERROR: '.red + "missing semicolon at the end of line on line: #{error_line}."
    true
  end

  def space_before_braces?(line, error_line)
    return false unless /\S\{/.match(line)

    puts 'ERROR: '.red + "missing space before open brace on line: #{error_line}."
    true
  end

  def check_complete_braces
    diff = (@opening_brace - @closing_brace).abs
    if diff.negative?
      puts 'ERROR: '.red + "Number of missing opening braces: #{diff}."
    elsif diff.positive?
      puts 'ERROR: '.red + "Number of missing closing braces: #{diff}."
    end
    true
  end

  def declare_spaces_around?(line, error_line)
    return false unless %r{\S\+|\+\S|\S\-|\-\S|\S\*|\*\S|\S\=|\=\S|\S/|/\S} =~ line

    puts 'ERROR: '.red + "spaces expected around an operator on line #{error_line}, " unless /\=\=\=|\=\=/ =~ line
    true
  end

  def read_lines
    (0..arr.size).each do |i|
      line = arr[i]
      triple_equality?(line, i + 1)
      pair_of_braces_count(line)
      declare_spaces_around?(line, i + 1)
      case_sensitive?(line, i + 1)
      underscore_in_names?(line, i + 1)
      space_before_braces?(line, i + 1)
      space_end_of_line?(line, i + 1)
      trailing_spaces?(line, i + 1)
      missing_semicolon?(line, i + 1)
    end
    check_complete_braces
  end

  private

  def pair_of_braces_count(line)
    @opening_brace += 1 if /\{/ =~ line
    @closing_brace += 1 if /\}/ =~ line
  end
end
