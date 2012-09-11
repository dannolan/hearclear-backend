APP_ROOT = File.expand_path(File.dirname(__FILE__)) unless defined?(APP_ROOT)

DataMapper.setup(:default, "sqlite:///#{APP_ROOT}/custinfo.db")

DataMapper.auto_upgrade!
load 'models/checkin.rb'
load 'models/session.rb'
load 'models/user.rb'
load 'models/venue.rb'