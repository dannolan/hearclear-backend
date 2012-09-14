require 'sinatra/base'
require 'sinatra/partial'
require 'haml'
require 'json'
require 'pp'
require 'data_mapper'
require 'will_paginate'
require 'will_paginate/data_mapper'
require 'will_paginate-bootstrap'


load 'routes/init.rb'
load 'models/init.rb'

class Backend < Sinatra::Base
	register Sinatra::Partial
	configure do
		set :public_folder, "#{File.dirname(__FILE__)}/public"
		set :views, "#{File.dirname(__FILE__)}/views"
		set :username, 'synergy'
		set :password, 'webinarwebinar'
		set :token, '8yasd908fuhas980fy023iuygbjhabkfklasdlfjkauoidfiuahlkhsdbfblhl'
		enable :logging, :dump_errors, :raise_errors
	end


	helpers do
		def admin?; request.cookies[settings.username] == settings.token; end
		def protected!; halt[401,"Nope"] unless admin?; end
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
	
	post "/login" do
		if params['username'] == settings.username && params['password'] == settings.password
			response.set_cookie(settings.username,settings.token)
			redirect "/farmer/dashboard"
		else
			redirect "/farmer/"
		end
	end
	
	get "/dashboard" do
		protected!
		@selected = "Dashboard"
		haml :"admin/dashboard", :layout => :"layouts/admin"
	end
	
	
	# get "/events" do
	# 	@selected = "Events"
	# 	haml :"admin/events", :layout => :"layouts/admin"
	# end
	
	get "/analyze" do
		protected!
		@selected = "Analyze"
		haml :"admin/analyze", :layout => :"layouts/admin"
	end

end