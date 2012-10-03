class Venue
	include DataMapper::Resource
	property :id, Serial
	property :name, String
	property :foursquareID, String
	property :latitude, String
	property :longitude, String
	
	has n, :checkins
	has 1, :venueloudness
	#id
	#venue name
	#foursquareID
	#has_many checkins
	#venue latitude
	#venue longitude
	#venue categories?
	
	def self.venue_for_foursquare_id(fsqid)
		@venue = Venue.first(:foursquareID => fsqid)
		return nil if @venue.nil?
		@venue
	end
	
	def lat_lon
		"#{self.latitude},#{self.longitude}"
	end
	
	def self.per_page
		20
	end
	
	def group_sessions
		pp	self.checkins.all.sessions
	end
	
	
end