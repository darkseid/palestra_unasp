require 'rubygems'
require 'net/http'
require 'rexml/document'
require 'md5'
require 'httpclient'

include REXML

UPLOAD = "http://api.flickr.com/services/upload/"   # URL de UPLOAD
FLICKR = 'http://api.flickr.com/services/rest/'     # URL base para os servicos do flickr
MY_KEY = '689ec9d7a901cff9b4c4b5ab22e6cb7b'         # minha key. Solicite a sua
MY_SIG = '4ab0b6aead490f3f'

def getToken frob
  args = {"api_key" => MY_KEY, "frob" => frob, "method" => "flickr.auth.getToken"}
  puts args.sort.to_s
  api_sig = MD5.hexdigest(MY_SIG + args.sort.to_s)
  puts "http://flickr.com/services/rest/?method=flickr.auth.getToken&api_key=#{MY_KEY}&frob=#{frob}&api_sig=#{api_sig}"
end

def upload token, file
  

  args = {"api_key" => MY_KEY, "auth_token" => token}
  api_sig = MD5.hexdigest(MY_SIG + args.sort.to_s)
  
  args.merge!(:api_sig => api_sig, :photo => File.new(file))
  
  res = HTTPClient.post URI.parse(UPLOAD), args
  puts res.body.inspect
end

if ARGV[0].eql? 'token'
  getToken ARGV[1]
elsif ARGV[0].eql? 'upload'
  upload ARGV[1], ARGV[2]
else

  args = {"api_key" => MY_KEY, "perms" => "write"}
  puts args

  api_sig = MD5.hexdigest(MY_SIG + args.to_s)
  puts api_sig

  puts args

  GET_TOKEN = URI.parse "http://flickr.com/services/auth/?api_key=#{MY_KEY}&perms=write&api_sig=#{api_sig}"
  puts GET_TOKEN

end



#response = Net::HTTP.get(URI.parse(GET_TOKEN))
#puts response




