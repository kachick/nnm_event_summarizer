# Copyright (C) 2010-2012  Kenichi Kamiya

require 'csv'
require 'logger'
require_relative 'networknodemanager/event'
require_relative 'networknodemanager/event/entry'
require_relative 'networknodemanager/event/entry/parser'
require_relative 'networknodemanager/event/configfile'
require_relative 'nnm_event_summarizer/csvformatter'
require_relative 'nnm_event_summarizer/csvformatter/originaly'
require_relative 'nnm_event_summarizer/csvformatter/oneline'

module NNM_Event_Summarizer

  VERSION = '0.0.2.a'.freeze

  CSV_OPTIONS = {
    headers: NNM_Event_Summarizer::CSVFormatter.headers,
    write_headers: true
  }.freeze


  class << self
    
    def run
      unless ARGV.length >= 1
        abort "usage: #{$PROGRAM_NAME} trapd.conf.1 [*trapd.conf.n]"
      end

      ARGV.each do |path|
        logger = Logger.new "#{path}.log"
        logger.progname = :'EventSummarizer'

        begin
          CSV.open "#{path}.summarize.csv", 'w', CSV_OPTIONS do |org_csv|
            CSV.open "#{path}.oneline.csv", 'w', CSV_OPTIONS do |line_csv|
              NetworkNodeManager::Event.foreach path do |entry|
                org_csv  << NNM_Event_Summarizer::CSVFormatter::Originaly.new(entry).values
                line_csv << NNM_Event_Summarizer::CSVFormatter::OneLine.new(entry).values
              end
            end
          end
        rescue Exception
          logger.fatal 'Error occurred'
          raise
        else
          logger.info 'Complete'
        end
      end      
    end

  end

end
