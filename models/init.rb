require 'data_mapper'
DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, "sqlite:///#{APP_ROOT}/../../shared/hearclear.db")

load 'models/user.rb'
load 'models/venue.rb'
load 'models/checkin.rb'
load 'models/session.rb'
load 'models/venueloudness.rb'

#zoidberg
DataMapper.finalize
DataMapper.auto_upgrade!