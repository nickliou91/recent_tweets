class TwitterUser < ActiveRecord::Base
		
	has_many :tweets
		
	def self.find_by_username(username)
			if TwitterUser.exists?(username: username)
				user = TwitterUser.find_by(username: username)
			else
				user = TwitterUser.create(username: username)
				if user.save
					user
				end
			end 
	end 

	def fetch_tweets!
	
		self.tweets.destroy_all
		user_tweets = TWITTER_CLIENT.user_timeline("#{username}")
		user_tweets.each do |tweet|
			self.tweets.create(body: tweet.text)
			end
	
		
	end

	def tweets_stale?
		latest_update = self.tweets.first.updated_at
		time_different = Time.now - latest_update
		time_different > 20
	end

end 


	
