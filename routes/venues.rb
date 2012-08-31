class Backend < Sinatra::Base

	get "/venues" do
		@selected = "Venues"
		haml :"admin/venues", :layout => :"layouts/admin"
	end
	
	get "/venue/:id" do
		@selected = "Venues"
		haml :"admin/venues/venue", :layout => :"layouts/admin"
		
	end


end