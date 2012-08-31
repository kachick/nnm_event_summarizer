$VERSION = true

require_relative '../lib/nnm_event_summarizer'

require 'declare'

sample =<<EOD
EVENT OV_IF_Marginal .1.3.6.1.4.1.11.2.17.1.0.40000000 "LOGONLY" Normal
FORMAT $7 failed
FORWARD some-host1 some-host2
NODE some-host3 some-host4
SDESC
foo

bar
EDESC
EOD

The NetworkNodeManager::Event::Entry.parse(sample) do |entry|
  
  is_a NetworkNodeManager::Event::Entry
  
  The entry.name do
    is 'OV_IF_Marginal'
  end
  
  The entry.oid do
    is '.1.3.6.1.4.1.11.2.17.1.0.40000000'
  end
  
  The entry.category do
    is :LOGONLY
  end
  
  The entry.severity do
    is :Normal
  end
  
  The entry.format do
    is '$7 failed'
  end
  
end

Declare.report