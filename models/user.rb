class User
	include DataMapper::Resource
	property :id, Serial
	property :deviceID, String
	property :device, String
	
	has n, :checkins
	#has_many checkins
	#UDID
	#device string
	
	
	
	def self.user_for_UDID(udid)
		@user = User.first(:deviceID => udid)
		return nil if @user.nil?
		@user
	end
	
end