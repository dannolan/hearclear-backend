require 'sinatra/base'
require 'sinatra/partial'
require 'haml'
require 'json'
require 'pp'
require 'data_mapper'
require 'will_paginate'
require 'will_paginate/data_mapper'
require 'will_paginate-bootstrap'


load 'models/init.rb'


class API < Sinatra::Base
	configure do
		set :public_folder, "#{File.dirname(__FILE__)}/public"
		enable :logging, :dump_errors, :raise_errors



	end
	
	#Submit checkin information
	#Check venue information
	#Create venues?
	
	
	error do
		content_type :json
		status 400
		e = env['sinatra.error']
		puts "error error error"
		pp e
		puts "error"
		{:result => 'error', :message => e.message}.to_json
	end
	
	not_found do
		content_type :json
		status 404
		puts "not found"
		{:result => "notfound", :message => "Request not found"}.to_json
	end
	
	
	
	get "/user/:id" do
		content_type :json
		# check for user, return status code if not existing
		@user = User.user_for_UDID(params[:id])
		
		halt(404) if @user.nil?
		
		halt(200)
	end
	
	post "/user/create" do
		content_type :json
		@data = JSON.parse(request.body.read) rescue {}
		pp @data
		if @data.has_key?('user')
			@userdata = @data['user']
			#pp @userdata
			
			@user = User.new(:deviceID => @userdata['deviceID'], :device => @userdata['device'])
			
			if @user.save
				halt(200)
			else
				pp @user.errors
				halt(403)
			end
		else
			halt(403)
		end
		
		
		halt(200)
	end
	
	
	post "/venue/new" do
		content_type :json
		@data = JSON.parse(request.body.read) rescue {}
		#pp @data
		if @data.has_key?('venue')
			#pp @data['venue']
			@venuedata = @data['venue']
			pp @venuedata
			@venue = Venue.new(:name => @venuedata['name'], :foursquareID => @venuedata['id'], :longitude => @venuedata['longitude'].to_s, :latitude => @venuedata['latitude'].to_s)
			
			if @venue.save
			
			halt(200)
			else
				pp @venue.errors
				halt(403)
			end
			#pp @venue
		else
			halt(403)
		end
		
		halt(200)
	end
	
	get "/venue/:id" do
		content_type :json
		@venue = Venue.venue_for_foursquare_id(params[:id])
		pp @venue
		halt(404) if @venue.nil?
		halt(200)
	end
 	
	
	post "/checkin/new" do
		content_type :json
		@data = JSON.parse(request.body.read) rescue {}
		pp @data
		if @data.has_key?('checkin')
			@checkin = @data['checkin']
			#venue from id
			#user from userid
			@venue = Venue.venue_for_foursquare_id(@checkin['ID'])
			@user = User.user_for_UDID(@checkin['deviceID'])
			@check_in = Checkin.new
			@venue.checkins << @check_in
			@user.checkins << @check_in
			# ID
			# name
			# deviceID
			# lat
			# lon
			if @checkin.has_key?('samples')
				@checkin['samples'].each do |sample|
					@session = Session.new(:timestamp => Session.datetime_from_timestring(sample['sampleDate']), :averageLevel => sample['avgSample'], :maxLevel => sample['maxSample'])
					@check_in.sessions << @session
					#pp @session
					@check_in.save
					#calculate the new venue group session times
					@venue.group_sessions
				end
			end
			
			
			# puts "====================="
			# pp @checkin
			# puts "====================="
		else
			halt(404)
		end
		halt(200)
	end
	
	
	get "/venue/:id/volume" do
		
		#TODO: Implement this to work properly so I can return volumes for an array of IDs
		halt(200)
	end
	
	
	
	
end