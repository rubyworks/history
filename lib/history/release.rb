class History

  # History release entry.
  #
  class Release

    # The full text of the release note.
    attr :text

    # The header.
    attr :header

    # The description.
    attr :notes

    # The list of changes.
    attr :changes

    # Version number (as a string).
    attr :version

    # Release date.
    attr :date

    # Nick name of the release, if any.
    attr :nickname

    #
    def initialize(text)
      @text = text.strip
      parse
    end

    # Returns the complete text.
    def to_s
      text
    end

  private

    # Parse the release text into +header+, +notes+
    # and +changes+ components.
    def parse
      lines = text.lines.to_a

      @header = lines.shift.strip

      parse_release_stamp(@header)

      # remove blank lines from top
      lines.shift until lines.first !~ /^\s+$/

      idx = find_changes(lines)

      if idx.nil?
        @notes   = lines.join
        @changes = ''
      elsif idx > 0
        @notes   = lines[0...idx].join
        @changes = lines[idx..-1].join
      else # hmmm... is this ever used?
        gap = lines.index{ |line| /^\s*$/ =~ line }
        @changes = lines[0...gap].join
        @notes   = lines[gap..-1].join
      end
    end

    # Parse out the different components of the header, such
    # as `version`, release `date` and release `nick name`.
    def parse_release_stamp(text)
      # version
      if md = /\b(\d+\.\d.*?)(\s|$)/.match(text)
        @version = md[1]
      end
      # date
      if md = /\b(\d+\-\d+\-.*?\d)(\s|\W|$)/.match(text)
        @date = md[1]
      end
      # nickname
      if md = /\"(.*?)\"/.match(text)
        @nickname = md[1]
      end
    end

    # Find line that looks like the start of a list of changes.
    def find_changes(lines)
      # look for a `changes` marker
      if idx = lines.index{ |line| /^changes\:?\s*$/i =~ line }
        return idx
      end

      # look for an enumerated list in reverse order
      if idx = lines.reverse.index{ |line| /^1\.\ / =~ line }
        idx = lines.size - idx - 1
        return idx 
      end

      # look for first outline bullet
      if idx = lines.index{ |line| /^\*\ / =~ line }
        return idx
      end

      return nil
    end

  end

end
