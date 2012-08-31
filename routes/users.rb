class Backend < Sinatra::Base

	get "/users" do
		@selected = "Users"
		haml :"admin/users", :layout => :"layouts/admin"
	end
	
	get "/users/:id" do
		@selected = "Users"
		haml :"admin/users/user", :layout => :"layouts/admin"
	end


end