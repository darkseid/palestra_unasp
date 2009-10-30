require 'rubygems'
require 'rexml/document'
require 'md5'
require 'httpclient'

include REXML

class Flickr

	UPLOAD = "http://api.flickr.com/services/upload/"   # URL de UPLOAD
	FLICKR = 'http://api.flickr.com/services/rest/'     # URL base para os servicos do flickr
	FLICKR_AUTH_URI = 'http://flickr.com/services/auth'
	MY_KEY = '689ec9d7a901cff9b4c4b5ab22e6cb7b'         # minha key. Solicite a sua
	MY_SIG = '4ab0b6aead490f3f'

	def get_token frob
		args = {"api_key" => MY_KEY, "frob" => frob, "method" => "flickr.auth.getToken"}
		args.merge!(:api_sig => MD5.hexdigest(MY_SIG + args.sort.to_s))
		
		url = build_url FLICKR, args
		
		puts "Copie e cole a URL abaixo no seu navegador, e obtenha o token:\n#{url}"
	end

	def upload token, file
  
		args = {"api_key" => MY_KEY, "auth_token" => token}
		args.merge!(:api_sig => MD5.hexdigest(MY_SIG + args.sort.to_s))
		
		# Adicionando a foto
		args.merge!(:photo => File.new(file))
		
		# Post com a foto
		response = HTTPClient.post URI.parse(UPLOAD), args
		
		d = Document.new response.body.content
		
		puts "Resultado do upload: #{d.root.attributes['stat']}"
	end
	
	def auth 
		args = {"api_key" => MY_KEY, "perms" => "write"}
		args.merge!(:api_sig => MD5.hexdigest(MY_SIG + args.sort.to_s))

		build_url FLICKR_AUTH_URI, args
	end

	:private
	
	#
	# Transfora um hash em uma query para url.
	# exemplo: { "name" => "rafael", "age" => 26} 
	# 	é convertido para: name=rafael&age=26
	#
	def stringify hash
		array_values = []
		hash.each do |key, value|
			array_values << "#{key}=#{value}"
		end
		"#{array_values.join("&")}"
	end
	
	def build_url base, args
		base + "?" + stringify(args)
	end
end

# mensagem de funcionamento do programa
puts "Comandos: \n auth: Para obter a url de autenticacao \n get_token: Para obter o token \n upload: para enviar uma foto ao flickr" if ARGV.empty?

f = Flickr.new

if ARGV[0].eql? "auth" 
	puts "Digite a seguinte url no seu navegador:\n #{f.auth}"
	puts "Copie o valor do parametro frob que apareceu no seu navegador e utilize com o comando get_token"
	
elsif ARGV[0].eql? "get_token"
	puts "Modo de usar: get_token <frob> (obtido com o comando auth)" if ARGV[1].nil?
	
	f.get_token ARGV[1]
	
elsif ARGV[0].eql? "upload"
	puts "Modo de usar: upload <token> <foto>" if ARGV.size != 3
	
	f.upload ARGV[1], ARGV[2]
	
end

