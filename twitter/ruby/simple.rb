require 'net/http'
require "rexml/document"

include REXML

public_timeline = Net::HTTP.get(URI.parse('http://twitter.com/statuses/public_timeline.xml'))
#puts public_timeline

doc = Document.new public_timeline

puts "###### Exibindo a timeline publica com Ruby ######"
doc.elements.each('statuses/status') do |status|
  puts "Status => #{status.elements['text'].text}"
end
