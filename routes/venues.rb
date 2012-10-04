class Backend < Sinatra::Base

	get "/venues" do
		protected!
		@selected = "Venues"
		@venues = Venue.all(:order => [:id.desc]).paginate(:page => params[:page])
		@collection = @venues
		#pp @venues
		haml :"admin/venues", :layout => :"layouts/admin"
	end
	
	get "/venues/:id" do
		protected!
		@selected = "Venues"
		@venue = Venue.get(params[:id])
		@venue.evaluate_outliers
		#pp @venue.group_sessions
		halt 404 if @venue.nil?
		haml :"admin/venues/venue", :layout => :"layouts/admin"
	end
	
	get "/venues/:id/sessions" do
		protected!
		@selected = "Venues"
		@venue = Venue.get(params[:id])
		halt 404 if @venue.nil?
		haml :"admin/venues/sessions", :layout => :"layouts/admin"
	end


end