require_relative '../lib/file_reader.rb'
require_relative '../lib/checks.rb'
file_data = ReadFileContent.new.fetch_file_content('./assets/bad_js_test_file.js')
parse_js_file = StyleGuides.new(file_data)
parse_js_file.read_lines
