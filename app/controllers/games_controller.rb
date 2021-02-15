require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters.push(('a'..'z').to_a.sample)
    end
  end
  
  def score
    user_input = params[:input]
    @letters = params[:letters].split

    if include_letters?(user_input, @letters) && word_exists?(user_input)
      @answer = "Congratulations! #{user_input} is a valid English word!"
    elsif include_letters?(user_input, @letters) == false
      @answer = "Sorry but #{user_input} can't be built out of #{@letters.join}"
    elsif word_exists?(user_input) == false
      @answer = "Sorry but #{user_input} does not seem to be a valid English word..."
    end
  end
end

def include_letters?(user_input, letters)
  user_input.chars.all? { |letter| user_input.count(letter) <= letters.count(letter) }
end

def word_exists?(user_input)
  response = open("https://wagon-dictionary.herokuapp.com/#{user_input}")
  json = JSON.parse(response.read)
  json['found']
end
