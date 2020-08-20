require_relative '../lib/file_reader.rb'
require_relative '../lib/checks.rb'

describe StyleGuides do
  let(:file_content) do
    %(
let FavColor = "green";
let Hobby = "football";
let best_music = "rock"
let fst = "first"
let scd = "first"
fst == scd
let interest;
interest = FavColor + Hobby+ best_music;

function detectoffencies() {
	let arr  = [7, 9, 5, 4, +8];
	let res = showError(arr);
}
if (condition) {
"go"


let x = 4, y = 9;
console.log\(x - y\);
function isOdd\(num\)\{
  return  num % 2 !== 0;
function exponent\(x, y\) \{
  return x ** y
\}
    )
  end

  let(:parse_js_file) { StyleGuides.new(file_content) }

  describe '#case_sensitive?' do
    it 'check if names indentifier starts with an uppercase letter' do
      expect(parse_js_file.case_sensitive?(file_content, 1)).not_to eql(false)
    end
  end

  describe '#missing_semicolon?' do
    it 'check for missing semicolon' do
      expect(parse_js_file.missing_semicolon?(file_content, 12)).to eql(true)
    end
  end

  describe '#trailing_spaces?' do
    let(:custom_method) do
      proc do
        parse_js_file.trailing_spaces?(file_content, 4)
      end
    end

    it 'check if there is a space before and after an operator' do
      expect(custom_method.call).to eql(true)
    end
  end
  describe '#space_before_braces?' do
    let(:custom_method) do
      proc do
        parse_js_file.space_before_braces?(file_content, 9)
      end
    end

    it 'check if there is a space before a brace' do
      expect(custom_method.call).to eql(true)
    end
  end
  describe '#check_complete_braces' do
    let(:custom_method) do
      proc do
        parse_js_file.check_complete_braces
      end
    end
    describe '#space_end_of_line?' do
      let(:custom_method) do
        proc do
          parse_js_file. space_end_of_line?(file_content, 4)
        end
      end

      it 'check if there is space at the end of a line' do
        expect(custom_method.call).not_to eql(false)
      end
    end

    describe '#space_end_of_line?' do
      let(:custom_method) do
        proc do
          parse_js_file.space_end_of_line?(file_content, 10)
        end
      end
      describe '#underscore_in__names?' do
        it 'check if names indetifier has an underscore' do
          expect(parse_js_file. underscore_in_names?(file_content, 1)).to eql(true)
        end
      end
      it 'check if there is double space in a line' do
        expect(custom_method.call).to eql(true)
      end
    end

    it 'check if there is a missing openning or closing braces' do
      expect(custom_method.call).to eql(true)
    end
  end
end
