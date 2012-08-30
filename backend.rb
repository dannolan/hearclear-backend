require 'sinatra/base'
require 'sinatra/partial'
require 'haml'
require 'json'

class Backend < Sinatra::Base

	configure do
		set :public_folder, "#{File.dirname(__FILE__)}/public"
		set :views, "#{File.dirname(__FILE__)}/views"
		enable :logging, :dump_errors, :raise_errors


	end


	not_found do
		haml "Not Found"
	end

	error do
		haml "Whoops"
	end

	get "/" do
		"Backend hi!"

	end

end