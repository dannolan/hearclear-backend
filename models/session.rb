class Session
	include DataMapper::Resource
	property :id, Serial
	property :timestamp, DateTime
	property :averageLevel, Float
	property :maxLevel, Float
	
	belongs_to :checkin
	
	
	def self.datetime_from_timestring(timestring)
		return DateTime.parse(timestring)
	end
	
	
	
	#timestamp
	#average
	#max
	#belongs to checkin
	
	
	
end