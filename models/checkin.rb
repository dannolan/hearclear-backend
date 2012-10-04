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
	
	def process_outliers
		levels = self.sessions.all.collect(&:averageLevel)
		std_dev = levels.standard_deviation
		mean = levels.mean
		q1 = mean - std_dev
		q2 = mean + std_dev
		self.sessions.each do |session|
			avgLevel = session.averageLevel
			if avgLevel >= q1 && avgLevel <= q2
				session.outlier = false
			else
				session.outlier = true
			end
			session.save
		end
	end
	
	
	def checkin_avg
		self.sessions.avg(:averageLevel, :outlier => false)
	end
	
	def checkin_peak
		self.sessions.avg(:maxLevel, :outlier => false)
	end
	
	def self.user_count_for_venue(user,venue)
		Checkin.all(:user => user, :venue => venue).count
	end
	
	
	def self.sessions_count_for_user(user)
		Checkin.all(:user => user).sessions.count
	end
	
	
	def average_string
		min = self.sessions.min(:averageLevel)
		max = self.sessions.max(:averageLevel)
		avg = self.sessions.avg(:averageLevel)
		"#{min}, #{max}, #{avg}"
	end
	
	
	def peak_string
		min = self.sessions.min(:maxLevel)
		max = self.sessions.max(:maxLevel)
		avg = self.sessions.avg(:maxLevel)
		"#{min}, #{max}, #{avg}"
	end
	
	#start_time
	
	#end_time
	
	#averagemaxvalues
	
	#averageaveragevalues
	
	
	
end