# Copyright (C) 2010-2012  Kenichi Kamiya

require 'forwardable'
require 'strscan'

module NetworkNodeManager; module Event; class Entry

  class Parser

    extend Forwardable
    
    SEPARATOR   = /#\n#\n#\n/
    FIELDS      = %w[main_values sub_values description].map(&:to_sym).freeze
    MAIN_VALUES = /^EVENT (\S+) (\S+) "([^"]+)" (\w+?)\n/
    SUB_HEADERS = %w(FORMAT EXEC DISPLAY FORWARD NODES).map(&:to_sym).freeze
    SUB_VALUES  = SUB_HEADERS.map{|header|/^(#{header}) (.*?)\n/}.freeze
    DESCRIPTION = /^SDESC\n(.*?)(?:EDESC)\n/m
    END_OF_CONFIGRATION ="#\n# End of configuration for event formats and actions\n#\n"
    
    class MalformedSourceError < StandardError; end

    def initialize(str, klass)
      @scanner = StringScanner.new str
      @result  = klass.new
    end
    
    def parse
      trim_header
      FIELDS.each{|field|__send__ "parse_#{field}"}
      trim_footer
      error 'Exist rest strings.' unless eos?
      @result
    end
    
    def_delegators :@scanner, :scan, :scan_until, :eos?, :rest, :terminate
    private :scan, :scan_until, :eos?, :rest, :terminate

    private
    
    def parse_main_values
      if scan MAIN_VALUES
        @result.name, @result.oid, @result.category,   @result.severity = \
        @scanner[1],  @scanner[2], @scanner[3].to_sym, @scanner[4].to_sym
      else
        error
      end
    end
    
    def parse_sub_values
      SUB_VALUES.each do |pattern|
        if scan_until pattern
          name = @scanner[1].downcase
          @result[name] = @scanner[2]
        end
      end
    end
    
    def parse_description
      if scan_until DESCRIPTION
        @result.description = @scanner[1]
      end
    end
    
    def trim_header
      trim_separator
    end
    
    def trim_footer
      if rest == END_OF_CONFIGRATION
        @result.eoc = true
        terminate
      else
        trim_separator
      end
    end
    
    def trim_separator
      scan SEPARATOR
    end
    
    def error(message=nil)
      raise MalformedSourceError, "Note: #{message}\nRest: #{rest}\nSource: #{$!}"
    end

  end

end; end; end