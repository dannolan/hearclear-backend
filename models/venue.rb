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
	
	#hardcoded for venue info
	def group_sessions
		set = self.checkins.all.sessions.group_by {|session| session.timestamp.strftime("%a")}
		if self.venueloudness.nil?
			self.venueloudness = Venueloudness.new
		end
		set.keys.each do |key|
			session_array = set[key]
			first = []
			second = []
			third = []
			fourth = []
			session_array.each do |session|
				session_time = Time.parse(session.timestamp.to_s)
				session_time = session_time + 10*60*60
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
			puts key
			str = key.downcase
			self.venueloudness.send("#{str}_first_block=",Venue.average_average_for_sessions(first))
			self.venueloudness.send("#{str}_second_block=",Venue.average_average_for_sessions(second))
			self.venueloudness.send("#{str}_third_block=",Venue.average_average_for_sessions(third))
			self.venueloudness.send("#{str}_fourth_block=",Venue.average_average_for_sessions(fourth))
			self.venueloudness.save
			pp self.venueloudness
			
		end
		
		
		#set.keys
		#take the set, lowercase it, then split until you're getting the right times then boom
	end
	
	def self.average_peak_for_sessions(session_array)
		float = 0.0
		return float if session_array.size == 0
		session_array.each do |session|
			float = float + session.maxLevel
		end
		float / session_array.size
	end
	
	def self.average_average_for_sessions(session_array)
		float = 0.0
		return float if session_array.size == 0
		session_array.each do |session|
			float = float + session.averageLevel
		end
		float/session_array.size
	end
	
	
end