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
	
	
	error do
		content_type :json
		status 400
		e = env['sinatra.error']
		{:result => 'error', :message => e.message}.to_json
	end
	
	not_found do
		content_type :json
		status 404
		
		{:result => "notfound", :message => "Request not found"}.to_json
	end
	
	
	
	post "venue/new" do
		pp params
		
		halt(200)
	end
	
	get "venue/:id" do
		content_type :json
		
		
		halt(404)
	end
 	
	
	post "/checkin/new" do
		if params.has_key?('checkin')
			#puts params
			#pp JSON.parse(params['checkin'])
		else
			puts params
			pp JSON.parse(params)
			
		end
		halt(200)
	end
	
	
	get "/venue/:id/volume" do
		
		
		halt(200)
	end
	
	
	
	
end