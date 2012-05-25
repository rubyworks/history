require 'fileutils'

FIXTURE_DIR = 'tmp/example/'

# Remove the example project if it exists.
Before :all do
  FileUtils.rm_r(FIXTURE_DIR) if File.exist?(FIXTURE_DIR)
  File.open(FIXTURE_DIR + '/.ruby', 'w'){ |f| f << "" }
end

When 'Given an empty project directory' do
  FileUtils.rm_r(FIXTURE_DIR) if File.exist?(FIXTURE_DIR)
end

When 'iven a ((([\.\w]+))) project file' do |name, text|
  FileUtils.mkdir_p(FIXTURE_DIR)
  File.open(FIXTURE_DIR + name, 'w') do |f|
    f << text
  end
end

When 'no ((([\.\w]+))) file in a project' do |name|
  FileUtils.rm(FIXTURE_DIR + name)
end

