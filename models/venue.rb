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
		set = self.checkins.all.sessions.group_by {|session| session.timestamp.strftime("%a")}
		set.keys.each do |key|
			session_array = set[key]
			first = []
			second = []
			third = []
			fourth = []
			session_array.each do |session|
				session_time = Time.parse(session.timestamp.to_s)
				if (session_time.hour > 6 && session_time.hour < 22)
					if(session_time.hour >= 6 && session_time.hour <10)
						
						first << session
					elsif(session_time.hour >= 10 && session_time.hour < 14)
						
						second << session
					elsif(session_time.hour >= 14 && session_time.hour < 18)
						
						third << session
					elsif(session_time.hour >= 18 && session_time.hour < 22)
						
						fourth << session
					end
				end
			end
		end
		
		puts "=================================="
		puts "First"
		pp first
		puts "Second"
		pp second
		puts "Third"
		pp third
		puts "Fourth"
		pp fourth
		puts "==================================="
		#set.keys
		#take the set, lowercase it, then split until you're getting the right times then boom
	end
	
	
end