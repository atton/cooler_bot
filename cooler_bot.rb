#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'user_stream'
require 'twitter'
require 'pp'

consumer_key = gets.chomp
consumer_secret = gets.chomp
oauth_token = gets.chomp
oauth_token_secret = gets.chomp

UserStream.configure do |config|
  config.consumer_key = consumer_key
  config.consumer_secret = consumer_secret
  config.oauth_token = oauth_token
  config.oauth_token_secret = oauth_token_secret
end

Twitter.configure do |config|
  config.consumer_key = consumer_key
  config.consumer_secret = consumer_secret
  config.oauth_token = oauth_token
  config.oauth_token_secret = oauth_token_secret
end

client = UserStream.client

def reply tweet , str
  # tweet に対してリプライする

  option = {"in_reply_to_status_id"=>tweet.id}
  msg = "@#{tweet.user.screen_name} #{str}"

  # duplicate とかすると落ちちゃうので、begin-rescue-end でゴリ押し。
  begin
  Twitter.update msg,option
  rescue
  end
end

# filter.json 使ってみる
client.endpoint = 'https://stream.twitter.com/'
client.post('/1/statuses/filter.json', track: '#ギークハウス沖縄') do |status|
  reply status,"クーラーください"
end

