require 'httparty'

class Siskel
  attr_reader :title

  def initialize(title, options = {})
    if !options.nil?
      if options[:year]
        @movie = HTTParty.get("http://www.omdbapi.com/?t=#{title}&y=#{options[:year]}")
      else
        @movie = HTTParty.get("http://www.omdbapi.com/?t=#{title}&plot=full")
      end
    else
      @movie = HTTParty.get("http://www.omdbapi.com/?t=#{title}")
      @title = @movie['Title']
    end
  end

  def rating
    @rating = @movie['Rated']
  end

  def year
    @year = @movie['Year']
  end

  def plot
    @plot = @movie['Plot']
  end

  def title
    @title = @movie['Title'] || @title = "Movie not found!"
  end

  def consensus
    @movie = HTTParty.get("http://www.omdbapi.com/?t=#{title}&tomatoes=true")

    if @movie['tomatoMeter'].to_i.between?(76, 100)
      @movie = "Two Thumbs Up"
    elsif @movie['tomatoMeter'].to_i.between?(51, 75)
      @movie = "Thumbs Up"
    elsif @movie['tomatoMeter'].to_i.between?(26, 50)
      @movie = "Thumbs Down"
    elsif @movie['tomatoMeter'].to_i.between?(0, 25)
      @movie = "Two Thumbs Down"
    end
  end
end

















