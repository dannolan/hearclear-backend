require 'data_mapper'
DataMapper::Logger.new($stdout, :debug)

DataMapper.setup(:default, "sqlite:///#{APP_ROOT}/hearclear.db")

load 'models/user.rb'
load 'models/venue.rb'
load 'models/checkin.rb'
load 'models/session.rb'


DataMapper.finalize
DataMapper.auto_upgrade!