#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

en = WikiData::Category.new('Category:Members of the House of Representatives (Nigeria)', 'en').member_titles |
     WikiData::Category.new('Category:Women members of the House of Representatives (Nigeria)', 'en').member_titles |
     WikiData::Category.new('Category:People\'s Democratic Party members of the House of Representatives (Nigeria)', 'en').member_titles |
     WikiData::Category.new('Category:Members of the House of Representatives (Nigeria) from Rivers State', 'en').member_titles |
     WikiData::Category.new('Category:Speakers of the House of Representatives (Nigeria)', 'en').member_titles

sparq = <<EOQ
  SELECT ?item WHERE {
    ?item p:P39 ?position_held .
    ?position_held ps:P39 wd:Q21290864 ;
                   pq:P2937 wd:Q20311259 .
  }
EOQ

ids = EveryPolitician::Wikidata.sparql(sparq)

EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { en: en })
