module Enumerable

		def sum
			self.inject(0){|accum, i| accum + i }
		end

		def mean
			self.sum/self.length.to_f
		end

		def sample_variance
			m = self.mean
			sum = self.inject(0){|accum, i| accum +(i-m)**2 }
			sum/(self.length - 1).to_f
		end

		def standard_deviation
			return Math.sqrt(self.sample_variance)
		end

end 

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
	
	
	def volume_bounds
		#silent, soft, low, average, loud, very loud, deafening
		#silent [0.00000000000000001 -> 0.1]
		#> 0, -> 0.1
		#soft [0.1 -> 0.2]
		#low [0.2 -> 0.3]
		#avg [0.3 -> 0.5]
		#loud[0.5 -> 0.65]
		#very loud [0.65 -> [0.8]
		#deafening [0.8 -> 1.0]
		bounds = []
		bounds << {:name => "Silent", :lowBound => 0.000000000001, :upBound => 0.1}
		bounds << {:name => "Soft", :lowBound => 0.1, :upBound => 0.2}
		bounds << {:name => "Low", :lowBound => 0.2, :upBound => 0.4}
		bounds << {:name => "Average", :lowBound => 0.4, :upBound => 0.5}
		bounds << {:name => "Loud", :lowBound => 0.5, :upBound => 0.65}
		bounds << {:name => "Very Loud", :lowBound => 0.65, :upBound => 0.8}
		bounds << {:name => "Deafening", :lowBound => 0.8, :upBound => 1.0}
		bounds
	end
	
	def venue_day_sets_no_outliers
		self.checkins.all.sessions.group_by {|session| session.timestamp.strftime("%a")}
	end
	
	def venue_day_sets
		self.checkins.all.sessions(:outlier => false).group_by {|session| session.timestamp.strftime("%a")}
	end
	
	#hardcoded for venue info
	def group_sessions
	
	end
	
	def day_max_volume_values_no_outliers
		day_sets = self.venue_day_sets_no_outliers
		return_set = {}
		day_sets.keys.each do |key|
			time_set = day_sets[key]
			return_set[key] = []
			grouped_set = time_set.group_by {|session| session.timestamp.strftime("%H:00")}
			#pp grouped_set
			grouped_set.keys.each do |time_key|
				time_period = {}
				time_period[:time] = time_key
				time_period[:average] = grouped_set[time_key].collect(&:maxLevel).mean
				return_set[key] << time_period
			end
		end
		return_set
	end
	
	def day_avg_volume_values_no_outliers
		day_sets = self.venue_day_sets_no_outliers
		return_set = {}
		day_sets.keys.each do |key|
			time_set = day_sets[key]
			return_set[key] = []
			grouped_set = time_set.group_by {|session| session.timestamp.strftime("%H:00")}
			#pp grouped_set
			grouped_set.keys.each do |time_key|
				time_period = {}
				time_period[:time] = time_key
				time_period[:average] = grouped_set[time_key].collect(&:averageLevel).mean
				return_set[key] << time_period
			end
		end
		return_set
	end
	
	def day_max_volume_values
		day_sets = self.venue_day_sets
		return_set = {}
		day_sets.keys.each do |key|
			time_set = day_sets[key]
			return_set[key] = []
			grouped_set = time_set.group_by {|session| session.timestamp.strftime("%H:00")}
			#pp grouped_set
			grouped_set.keys.each do |time_key|
				time_period = {}
				time_period[:time] = time_key
				time_period[:average] = grouped_set[time_key].collect(&:maxLevel).mean
				return_set[key] << time_period
			end
		end
		return_set
	end
	
	
	def day_volume_values
		day_sets = self.venue_day_sets
		return_set = {}
		day_sets.keys.each do |key|
			time_set = day_sets[key]
			return_set[key] = []
			grouped_set = time_set.group_by {|session| session.timestamp.strftime("%H:00")}
			#pp grouped_set
			grouped_set.keys.each do |time_key|
				time_period = {}
				time_period[:time] = time_key
				time_period[:average] = grouped_set[time_key].collect(&:averageLevel).mean
				return_set[key] << time_period
			end
		end
		return_set
	end
	
	def volume_average
		#day_volume_values
		self.checkins.sessions.avg(:averageLevel, :outlier => false)
	end
	
	
	def evaluate_outliers
		bound_tuple = self.venue_deviation_bounds
		lower = bound_tuple[0]
		upper = bound_tuple[1]
		#all venues within the bounds are true
		#all venues outside of the bounds are false
		self.checkins.sessions(:averageLevel.gte => lower, :averageLevel.lte => upper).each do |session|
			session.outlier = false
			session.save
		end
		
		self.checkins.sessions(:averageLevel.lt => lower) | self.checkins.sessions(:averageLevel.gt => upper).each do |session|
			session.outlier = true
			session.save
		end		
	end
	
	
	#lower bound and upper bound for the venue
	def venue_deviation_bounds
		tuple = [0,1]
		return tuple if self.checkins.sessions.count < 2
		data_set = self.checkins.sessions.collect(&:averageLevel)
		mean = data_set.mean
		lower_bound = mean - data_set.standard_deviation
		upper_bound = mean + data_set.standard_deviation
		[lower_bound,upper_bound]
	rescue Exception => e
		pp e
		return [0,1]
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