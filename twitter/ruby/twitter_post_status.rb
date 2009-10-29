require 'rubygems'
require 'twitter'


# autenticando no twitter via HTTPAuth (deprecated, utilize OAuth)
httpauth = Twitter::HTTPAuth.new('rafael_unasp', 'rafael')

if not ARGV[0].nil?
  client = Twitter::Base.new(httpauth)
  client.update(ARGV[0])

  #exibe a timeline dos amigos que sigo
  client.friends_timeline.each { |tweet| puts tweet.text }
end
