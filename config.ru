require 'rubygems'
require 'bundler'
require './landing.rb'
require './backend.rb'
require './api.rb'

$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
Dir.glob("#{File.dirname(__FILE__)}/lib/*.rb") { |lib| require File.basename(lib, '.*') }

FileUtils.mkdir_p 'log' unless File.exists?('log')
log = File.new("log/sinatra.log", "a")
$stdout.reopen(log)
$stderr.reopen(log)

map "/" do
	run Landing
end

map "/farmer" do
	run Backend
end

map "/api/v1" do
	run API
end