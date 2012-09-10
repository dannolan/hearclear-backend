require 'sinatra/base'
require 'sinatra/partial'
require 'haml'
require 'json'
require 'pp'


class API < Sinatra::Base
	configure do
		set :public_folder, "#{File.dirname(__FILE__)}/public"
		enable :logging, :dump_errors, :raise_errors


	end
	
	#Submit checkin information
	#Check venue information
	#Create venues?
	
	
	
	
	post "venue/new" do
		pp params
		
		halt(200)
	end
	
	get "venue/:id" do
		
		halt(404)
	end
 	
	
	post "/checkin/new" do
		pp params
		halt(200)
	end
	
	
	get "/venue/:id/volume" do
		
		
		halt(200)
	end
	
	
	
	
end