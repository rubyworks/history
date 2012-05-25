#require 'history/core_ext'
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
  HEADER_RE = /^[=#]+\s*\d+\.\S+/

  # Convenience constant for `File::FNM_CASEFOLD`.
  CASEFOLD = File::FNM_CASEFOLD

  #
  def self.parse(text, opts={})
    opts[:text] = text
    new(opts[:file], opts)
  end

  def self.text(text, opts={})
    parse(text, opts)
  end

  #
  def self.file(file)
    new(file)
  end

  #
  def self.find(root=Dir.pwd)
    file = Dir.glob(File.join(root, DEFAULT_FILE), CASEFOLD).first
    new(file)
  end

  # HISTORY file's path.
  attr :file

  # HISTORY file's raw contents.
  attr :text

  # List of release entries.
  attr :releases

  # New History.
  def initialize(file=nil, opts={})
    if Hash === file
      opts = file
      file = nil
    end

    @file = file
    @text = opts[:text]

    if @file
      # if file is given but no text, raise error if file not found
      raise "file not found" unless File.exist?(@file) unless @text
    else
      @file = Dir.glob(DEFAULT_FILE, CASEFOLD).first || 'HISTORY'
    end

    unless @text
      @text = File.read(@file) if File.exist?(@file)
    end

    parse
  end

  # Read and parse the Histoy file.
  def parse
    @releases = []
    entry = nil

    if text
      text.each_line do |line|
        if HEADER_RE =~ line
          @releases << Release.new(entry) if entry
          entry = line
        else
          next unless entry
          entry << line
        end
      end
      @releases << Release.new(entry)
    end
  end

  # Lookup release by version.
  def [](version)
    releases.find{ |r| r.version == version }
  end

  # Returns first entry in releases list.
  def release
    releases.first
  end

end #class History
