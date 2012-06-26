require 'forwardable'

module NNM_Event_Summarizer

  class CSVFormatter

    extend Forwardable
    
    HEADERS = %w(Name OID Enable? Category Severity Format Execute
                Display Forward Nodes Description).freeze
    
    VALUES = HEADERS.map(&:downcase).freeze
    
    def self.headers
      HEADERS
    end
    
    def_delegators :@entry, *VALUES, :sources
    
    def initialize(entry)
      @entry = entry
    end

    def values(description)
      vals = VALUES.dup
      vals.delete_at(-1)
      [*vals.map{|name|__send__ name}, description]
    end

  end

end

require_relative 'csvformatter/originaly'
require_relative 'csvformatter/oneline'