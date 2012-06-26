module NNM_Event_Summarizer; class CSVFormatter

  class OneLine < self
    def values
      super description && description.gsub("\n", '\n')
    end
  end

end; end
