require 'pathname'
require 'history/release'

# The History class is a HISTORY file parser. It parses HISTORY files
# into a structure of individual release sections.
#
# The file is expected to be in RDoc or simple Markdown format with
# each section beginning with a secondary header (`==` or `##`) giving
# *version* and *date* of release, then a *note* followed by a point by
# point outline of *changes*.
#
# For example:
#
#   == 1.0.0 / 2009-10-07
#
#   Say something about this version.
#
#   Changes:
#
#   * outline oimportant changelog items
#
# `Changes:` is used as a parsing marker. While optional, it helps the 
# parser find the list of changes, rather than looking for an asterisk
# or digit, so that ordered and unordered lists can be used in the note
# section too.
#
# Ideally, this class will be continuely imporved to handle greater 
# variety of layout.
#
class History

  # File glob for finding the HISTORY file.
  DEFAULT_FILE = '{History}{,.*}'

  # Match against version number string.
  HEADER_RE = /^[=#]+\s*v?\d+\.\S+/

  # Convenience constant for `File::FNM_CASEFOLD`.
  CASEFOLD = File::FNM_CASEFOLD

  # Parse history from given text.
  def self.parse(text)
    new(text.to_s)
  end

  # Read and parse history from given file.
  def self.read(file)
    new(Pathname.new(file))
  end

  # Lookup history file given a project root directory.
  # If a history file is not present, assume a default
  # file name of `HISTORY`.
  def self.at(root=Dir.pwd)
    if file = Dir.glob(File.join(root, DEFAULT_FILE), CASEFOLD).first
      new(Pathname.new(file))
    else
      file = File.join(root, 'HISTORY')
      new(:file=>file)
    end
  end

  # Alias for #at.
  def self.find(root=Dir.pwd)
    at(root)
  end

  # Does a HISTORY file exist?
  def self.exist?(path=Dir.pwd)
    if File.directory?(path)
      Dir.glob(File.join(path, DEFAULT_FILE), CASEFOLD).first
    else
      File.exist?(path) ? path : false
    end
  end

  # HISTORY file's path.
  attr :file

  # HISTORY file's raw contents.
  attr :text

  # List of release entries.
  attr :releases

  # New History.
  def initialize(io=nil, opts={})
    if Hash === io
      opts = io
      io   = nil
    end

    @releases = []

    case io
    when String
      parse(io)
    when Pathname
      @file = io
      parse(io.read)
    when File
      @file = io.path
      parse(io.read)
    else
      parse(io.read) if io
    end

    # file can be overidden
    @file = opts[:file] if opts.key?(:file)
  end

  # Does history file exist?
  def exist?
    File.file?(@file)
  end

  # Parse History text.
  def parse(text)
    return unless text
    releases, entry = [], nil
    text.each_line do |line|
      if HEADER_RE =~ line
        releases << Release.new(entry) if entry
        entry = line
      else
        next unless entry
        entry << line
      end
    end
    releases << Release.new(entry) if entry
    @releases = releases
  end

  # Lookup release by version.
  def [](version)
    releases.find{ |r| r.version == version }
  end

  # Returns first entry in release list.
  def release
    releases.first
  end

end #class History
