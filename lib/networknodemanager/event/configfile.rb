require_relative 'entry'

module NetworkNodeManager; module Event

  module ConfigFile

    def each_entry
      trim_header
      
      each_line SEPARATOR do |section|
        entry = Entry.parse section
        yield entry
        break if entry.eoc?
      end
    end
    
    private
    
    def trim_header
      until readline == "# Event formats and actions:\n"
      end
    end

  end

end; end
