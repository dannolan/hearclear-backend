require 'sinatra/base'
require 'sinatra/partial'
require 'haml'
require 'json'
require 'pp'


load 'routes/init.rb'
load 'models/init.rb'

class Backend < Sinatra::Base
	register Sinatra::Partial
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
		haml :"admin/login", :layout => :"layouts/adminlogin"
	end
	
	get "/dashboard" do
		@selected = "Dashboard"
		haml :"admin/dashboard", :layout => :"layouts/admin"
	end
	
	
	# get "/events" do
	# 	@selected = "Events"
	# 	haml :"admin/events", :layout => :"layouts/admin"
	# end
	
	get "/analyze" do
		@selected = "Analyze"
		haml :"admin/analyze", :layout => :"layouts/admin"
	end

end