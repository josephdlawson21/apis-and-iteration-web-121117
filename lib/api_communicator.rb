require 'rest-client'
require 'json'
require 'pry'


def find_character_movies(get_character_movies_from_api,character)
  movie_array = []
  while movie_array.length == 0
    if get_character_movies_from_api['next'] != nil
      get_character_movies_from_api["results"].each do |character_name|
        if character == character_name["name"].downcase
          movie_array = character_name["films"]
        end
      end
      # binding.pry
      get_character_movies_from_api = get_character_movies_from_api(character, get_character_movies_from_api["next"])
      # binding.pry
    else
      return puts "invalid entry"
    end
  end
  movie_array
end

def get_movie_array(find_character_movies)
  result = []
  find_character_movies ||= []
  find_character_movies.each do |movie_link|
    hold = RestClient.get(movie_link)
    result << JSON.parse(hold)
  end
  result
end

def leave
  puts "Thanks!"
end


def get_character_movies_from_api(character, page = 'http://www.swapi.co/api/people/')
  #make the web request
  all_characters = RestClient.get(page)
  character_hash = JSON.parse(all_characters)
  # binding.pry
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_hash)
  films_hash.each do |film|
    puts film["title"]
  end
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  films_hash = find_character_movies(films_hash,character)
  films_hash = get_movie_array(films_hash)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
