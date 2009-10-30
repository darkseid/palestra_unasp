require 'rubygems'
require 'net/http'
require 'rexml/document'


include REXML

FLICKR = 'http://api.flickr.com/services/rest/'     # URL base para os servicos do flickr
MY_KEY = '689ec9d7a901cff9b4c4b5ab22e6cb7b'         # minha key. Solicite a sua

tags = ARGV[0]
per_page = ARGV[1].nil? ? 10 : ARGV[1] 

if tags.nil?
  puts "Digite as tags para a busca"
else
  response = Net::HTTP.get(URI.parse("#{FLICKR}/?method=flickr.photos.search&api_key=#{MY_KEY}&tags=#{tags}&per_page=#{per_page}"))

  # Parseando o retorno
  d = Document.new(response)
  
  # criando a url. Fonte: http://www.flickr.com/services/api/misc.urls.html  
  d.elements.each("rsp/photos/photo") do |photo|
    puts "http://farm#{photo.attributes['farm']}.static.flickr.com/#{photo.attributes['server']}/#{photo.attributes['id']}_#{photo.attributes['secret']}.jpg"
  end
  
end


