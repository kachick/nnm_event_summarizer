require 'striuct'

module NetworkNodeManager; module Event

  Entry = Striuct.define do
    
    alias_method :original_format, :format
    undef_method :format
    
    alias_method :original_exec, :exec
    undef_method :exec
    
    alias_method :original_display, :display
    undef_method :display
    
    member :name, AND(String, /\A[^\n]+\z/)
    member :oid, AND(String, /\A(?:\.\d+)+(?:\.\*)?\z/)
    member :category, AND(Symbol, /\A[^\n]+\z/)
    member :severity, AND(Symbol, /\A\w+\z/)
    member :format, String
    member :exec, OR(String, nil)
    alias_member :execute, :exec
    member :display, OR(String, nil)
    member :forward, AND(String, /\A(\S+ ?)*\z/)
    member :nodes, AND(String, /\A(\S+ ?)*\z/)
    member :description, OR(String, nil)
    member :eoc, BOOLEAN?
    
    def eoc?
      !!eoc
    end
    
    def sources
      nodes && nodes.scan(/\S+/)
    end
    
    def enable?
      case category
      when :LOGONLY, :IGNORE
        false
      else
        true
      end
    end

  end

end; end

require_relative 'entry/singletonclass'