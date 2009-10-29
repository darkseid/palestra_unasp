require 'rubygems'
require 'twitter'

#metodo firehose = timeline publica do twitter

puts "###### Exibindo a timeline publica com ruby e a gem twitter ######"
Twitter.firehose.each { |tweet| puts "status => #{tweet.text}" }
