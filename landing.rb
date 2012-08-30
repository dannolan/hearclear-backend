require 'rubygems'
require 'sinatra/base'
require 'sinatra/partial'
require 'haml'
require 'json'

APP_ROOT = File.expand_path(File.dirname(__FILE__)) unless defined?(APP_ROOT)


class Landing < Sinatra::Base
	
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
		haml :"landing/index", :layout => :"layouts/landing"
	end
	
end