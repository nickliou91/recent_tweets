class CreateTweets < ActiveRecord::Migration
  def change
  	create_table :tweets do |t|
  		t.text :body
  		t.text :author_name
  		t.integer :twitter_user_id
  		t.timestamps
  	end 
  end
end
