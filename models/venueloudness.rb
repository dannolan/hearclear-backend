class Venueloudness
	include DataMapper::Resource
	property :id, Serial
	
	property :venue_loudness_rate, Float, :default => 0.0
	
	property :mon_first_block, Float, :default => 0.0
	property :mon_second_block, Float, :default => 0.0
	property :mon_third_block, Float, :default => 0.0
	property :mon_fourth_block, Float, :default => 0.0
	
	
	property :tue_first_block, Float, :default => 0.0
	property :tue_second_block, Float, :default => 0.0
	property :tue_third_block, Float, :default => 0.0
	property :tue_fourth_block, Float, :default => 0.0
	
	property :wed_first_block, Float, :default => 0.0
	property :wed_second_block, Float, :default => 0.0
	property :wed_third_block, Float, :default => 0.0
	property :wed_fourth_block, Float, :default => 0.0
	
	property :thu_first_block, Float, :default => 0.0
	property :thu_second_block, Float, :default => 0.0
	property :thu_third_block, Float, :default => 0.0
	property :thu_fourth_block, Float, :default => 0.0
	
	
	property :fri_first_block, Float, :default => 0.0
	property :fri_second_block, Float, :default => 0.0
	property :fri_third_block, Float, :default => 0.0
	property :fri_fourth_block, Float, :default => 0.0
	
	
	property :sat_first_block, Float, :default => 0.0
	property :sat_second_block, Float, :default => 0.0
	property :sat_third_block, Float, :default => 0.0
	property :sat_fourth_block, Float, :default => 0.0
	
	property :sun_first_block, Float, :default => 0.0
	property :sun_second_block, Float, :default => 0.0
	property :sun_third_block, Float, :default => 0.0
	property :sun_fourth_block, Float, :default => 0.0
	
	belongs_to :venue
	
	
	def calculate_values
		%w(Sun Mon Tue Wed Thu Fri Sat).each do |day_shortcode|
			#iterate through the days collecting the set of dates that match that date that are between 0600 and 2200
			#then group by the hour
			#calculate using the summed averages to get the average values for each element
			
			
		end
	end
	
	def search_for_day(day_shortcode)
		
	end

	def average_for_set(set_of_sessions)
		
	end
	
end