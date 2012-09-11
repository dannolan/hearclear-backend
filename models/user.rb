class User
	include DataMapper::Resource
	property :id, Serial
	property :deviceID, String
	property :device, String
	
	has_n :checkins
	#has_many checkins
	#UDID
	#device string
	
	
	
end