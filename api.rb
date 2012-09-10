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
		content_type :json
		@data = JSON.parse(request.body.read) rescue {}
		pp @data
		
		halt(200)
	end
	
	get "venue/:id" do
		content_type :json
		
		
		halt(404)
	end
 	
	
	post "/checkin/new" do
		
		@data = JSON.parse(request.body.read) rescue {}
		pp @data
		if @data.has_key?('checkin')
			@checkin = @data['checkin']
			puts "====================="
			pp @checkin
			puts "====================="
		else
			halt(404)
		end
		halt(200)
	end
	
	
	get "/venue/:id/volume" do
		
		
		halt(200)
	end
	
	
	
	
end