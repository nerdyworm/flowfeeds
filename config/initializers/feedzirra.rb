# Add the enclosure element to all feed types
Feedzirra::Feed.add_common_feed_entry_element('enclosure', :value => :url, :as => :enclosure_url)

# Add iTunes parser to feedzirra's available parsers
Feedzirra::Feed.add_feed_class(Feedzirra::Parser::ITunesRSS)

class Feedzirra::Parser::RSSEntry
  def guid
    entry_id
  end
end
