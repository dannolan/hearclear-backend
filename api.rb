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
	
	
	post "/user/info" do
		
	
		
	end
	
	post "/user/new" do
	
	
	
	end
	
	
	post "/checkin/info" do
		
		
	end
	
	
	post "/checkin/new" do
		
		
	end
 	
	
	post "/session/new" do
		
		
	end
	
	post "/session/update" do
		
		
	end
	
	post "/session/conclude" do
		
		
		#process_session
	end
	
	
	
	
end