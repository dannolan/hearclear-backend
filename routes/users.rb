class Backend < Sinatra::Base

	get "/users" do
		protected!
		@selected = "Users"
		@users = User.all.paginate(:page => params[:page])
		@collection = @users
		haml :"admin/users", :layout => :"layouts/admin"
	end
	
	get "/users/:id" do
		protected!
		@selected = "Users"
		@user = User.get(params[:id])
		halt 404 if @user.nil?
		haml :"admin/users/user", :layout => :"layouts/admin"
	end


end