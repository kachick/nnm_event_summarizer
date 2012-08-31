# Copyright (C) 2010-2012  Kenichi Kamiya

require 'csv'
require 'logger'
require_relative 'networknodemanager/event'
require_relative 'networknodemanager/event/entry'
require_relative 'networknodemanager/event/entry/parser'
require_relative 'networknodemanager/event/configfile'
require_relative 'nnm_event_summarizer/version'
require_relative 'nnm_event_summarizer/csvformatter'
require_relative 'nnm_event_summarizer/csvformatter/originaly'
require_relative 'nnm_event_summarizer/csvformatter/oneline'

module NNM_Event_Summarizer

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
          CSV.open "#{path}.summary.csv", 'w', CSV_OPTIONS do |org_csv|
          CSV.open "#{path}.summary.oneline.csv", 'w', CSV_OPTIONS do |line_csv|
          CSV.open "#{path}.summary.oneline.each_ip.csv", 'w', headers: ['SRC', *NNM_Event_Summarizer::CSVFormatter.headers], write_headers: true do |oneline_csv_each_ip|
            NetworkNodeManager::Event.foreach path do |entry|
              org_csv  << NNM_Event_Summarizer::CSVFormatter::Originaly.new(entry).values
              oneline_values = NNM_Event_Summarizer::CSVFormatter::OneLine.new(entry).values
              line_csv << oneline_values
              
              if entry.sources && !(entry.sources.empty?)
                entry.sources.each do |source|
                  oneline_csv_each_ip << [source, *oneline_values]
                end
              else
                oneline_csv_each_ip << [nil, *oneline_values]
              end
            end
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
