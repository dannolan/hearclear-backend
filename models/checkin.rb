class Checkin
	include DataMapper::Resource
	property :id, Serial
	
	belongs_to :user
	belongs_to :venue
	has_n, :sessions
	
	#belongs_to user
	#belongs_to venue
	#has_many sessions
	
	
	#start_time
	
	#end_time
	
	#averagemaxvalues
	
	#averageaveragevalues
	
	
	
end