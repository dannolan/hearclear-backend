class Checkin
	include DataMapper::Resource
	property :id, Serial
	property :user_estimate, Float
	
	has n, :sessions

	belongs_to :user
	belongs_to :venue
		
	#belongs_to user
	#belongs_to venue
	#has_many sessions
	
	
	def self.user_count_for_venue(user,venue)
		Checkin.all(:user => user, :venue => venue).count
	end
	
	
	def self.sessions_count_for_user(user)
		Checkin.all(:user_id => venue).sessions.count
	end
	
	#start_time
	
	#end_time
	
	#averagemaxvalues
	
	#averageaveragevalues
	
	
	
end