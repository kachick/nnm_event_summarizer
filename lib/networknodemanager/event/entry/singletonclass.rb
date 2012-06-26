require_relative 'parser'

module NetworkNodeManager; module Event; class Entry

  class << self

    def parse(str)
      self::Parser.new(str, self).parse
    end

  end

end; end; end
