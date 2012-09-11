class Venue
	include DataMapper::Resource
	property :id, Serial
	property :name, String
	property :foursquareID, String
	property :latitude, String
	property :longitude, String
	
	has n, :checkins
	#id
	#venue name
	#foursquareID
	#has_many checkins
	#venue latitude
	#venue longitude
	#venue categories?
	
	
end