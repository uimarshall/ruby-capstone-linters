class ReadFileContent
  def fetch_file_content(file_path)
    file = File.open(file_path)
    content = file.readlines.map(&:chomp)
    file.close
    content
  end
end