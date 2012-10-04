require 'data_mapper'
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

DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, "sqlite:///#{APP_ROOT}/../../shared/hearclear.db")

load 'models/user.rb'
load 'models/venue.rb'
load 'models/checkin.rb'
load 'models/session.rb'
load 'models/venueloudness.rb'

#zoidberg
DataMapper.finalize
DataMapper.auto_migrate!
#DataMapper::Model.descendants.each {|m| m.auto_upgrade! if m.superclass == Object}