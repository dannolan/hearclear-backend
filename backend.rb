require 'sinatra/base'
require 'sinatra/partial'
require 'haml'
require 'json'
require 'pp'
require 'data_mapper'
require 'dm-aggregates'
require 'will_paginate'
require 'will_paginate/data_mapper'
require 'will_paginate-bootstrap'


load 'routes/init.rb'
load 'models/init.rb'

class Backend < Sinatra::Base
	register Sinatra::Partial
	register WillPaginate::Sinatra
	configure do
		set :public_folder, "#{File.dirname(__FILE__)}/public"
		set :views, "#{File.dirname(__FILE__)}/views"
		set :username, 'synergy'
		set :password, 'webinarwebinar'
		set :token, '8yasd908fuhas980fy023iuygbjhabkfklasdlfjkauoidfiuahlkhsdbfblhl'
		enable :logging, :dump_errors, :raise_errors, :show_exceptions
	end


	helpers do
		def admin?; request.cookies[settings.username] == settings.token; end
		def protected!; redirect "/farmer/" unless admin?; end
		def logout; request.cookies[settings.username] == nil; end
	end


	not_found do
		haml "Not Found"
	end

	# error do
	# 	haml "Whoops"
	# end

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
		@users = User.all(:order => [:id.desc], :limit => 5)
		@checkins = Checkin.all(:order => [:id.desc], :limit => 5)
		@venues = Venue.all(:order => [:id.desc], :limit => 5)
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