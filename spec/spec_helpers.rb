def fixture_file_path(filename)
  File.join(File.dirname(__FILE__), filename).to_s
end

def fixture_file(filename)
  File.read(fixture_file_path(filename))
end
