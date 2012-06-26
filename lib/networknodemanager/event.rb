require_relative 'event/configfile'

module NetworkNodeManager

  module Event

    FORMAT_VERSION = 3
    SEPARATOR = "\n#\n#\n#\n"
    
    module_function
    
    def foreach(path)
      open path do |f|
        f.extend(ConfigFile).each_entry do |entry|
          yield entry
        end
      end
    end
    
    def for_io(io)
      [].tap do |result|
        io.extend(ConfigFile).each_entry do |entry|
          result << entry
        end
      end
    end
    
    def load(path)
      open path do |f|
        return for_io(f)
      end
    end

  end

end