get '/' do
  # Look in app/views/index.erb
  erb :index
end


get '/:username' do 

	# @user = TwitterUser.find_by_username(params[:username])
	# if @user.tweets.empty?
		 
	# 	 @user.fetch_tweets!

	# end
	# @tweets =  @user.tweets.limit(10)
	erb :index
	
end 

get '/:username/refresh' do
	@user = TwitterUser.find_by_username(params[:username])
	if ( @user.tweets.empty? || @user.tweets_stale? )
		@user.fetch_tweets!
	end 
	@tweets = @user.tweets.limit(10)
	erb :tweets, layout: false 

end 