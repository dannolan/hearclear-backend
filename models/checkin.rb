class Checkin
	include DataMapper::Resource
	property :id, Serial
	
	has n, :sessions

	belongs_to :user
	belongs_to :venue
		
	#belongs_to user
	#belongs_to venue
	#has_many sessions
	
	
	#start_time
	
	#end_time
	
	#averagemaxvalues
	
	#averageaveragevalues
	
	
	
end