#!/usr/local/bin/ruby
# -*- coding: utf-8 -*-

require 'user_stream'
require 'pp'

UserStream.configure do |config|
  config.consumer_key = gets.chomp
  config.consumer_secret = gets.chomp
  config.oauth_token = gets.chomp
  config.oauth_token_secret = gets.chomp
end

client = UserStream.client

def check_tags tags,tag_text
  
  tags.each do |tag|
    return true if tag.text == tag_text
  end
  false
end

client.user do |status|
  if status.has_key? "text"
    if !status.entities.hashtags.empty?
      p check_tags(status.entities.hashtags , "ギークハウス沖縄")
    end
  end
end

