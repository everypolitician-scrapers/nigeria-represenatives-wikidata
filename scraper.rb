#!/bin/env ruby
# encoding: utf-8

require 'wikidata/fetcher'

en = WikiData::Category.new('Category:Members of the House of Representatives (Nigeria)', 'en').member_titles |
     WikiData::Category.new('Category:Women members of the House of Representatives (Nigeria)', 'en').member_titles |
     WikiData::Category.new('Category:People\'s Democratic Party members of the House of Representatives (Nigeria)', 'en').member_titles |
     WikiData::Category.new('Category:Members of the House of Representatives (Nigeria) from Rivers State', 'en').member_titles |
     WikiData::Category.new('Category:Speakers of the House of Representatives (Nigeria)', 'en').member_titles

sparq = 'SELECT ?item WHERE { ?item wdt:P39 wd:Q21290864 }'
ids = EveryPolitician::Wikidata.sparql(sparq)

EveryPolitician::Wikidata.scrape_wikidata(ids: ids, names: { en: en })
