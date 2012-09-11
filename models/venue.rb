class Venue
	include DataMapper::Resource
	property :id, Serial
	property :foursquareID, String
	property :latitude, String
	property :longitude, String
	
	has_n, :checkins
	#id
	#venue name
	#foursquareID
	#has_many checkins
	#venue latitude
	#venue longitude
	#venue categories?
	
	
end