# Siskel

During this mini-hackathon, you will work in small groups to create *Siskel*, an object that grabs movie data using the [OMDb API](http://www.omdbapi.com/). To do so, you've been provided with a file, `test.rb`, containing failing tests. It is your job to make as many of these tests pass in the time provided.

Throughout this process, you will gain experience working with APIs, learn more ways you can use classes within your applications, and use tests to dictate the design of your project.

## Getting Started

Fork this repo, then clone it to your desktop so you can work on your local environment.

Once inside the `siskel` project directory, use `ruby test.rb` to run your test file.

```sh
$ ruby test.rb 
Run options: --seed 10217

# Running:

.

Finished in 0.112265s, 8.9075 runs/s, 8.9075 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips
```

You will notice that we have one passing test. To get you started, we have gone ahead and written some code to make the first test pass.

```ruby
# test.rb 

class TestSiskel < Minitest::Test

  def test_movie_title
    movie = Siskel.new("Kill Bill")
    assert_equal "Kill Bill: Vol. 1", movie.title
  end

end
```

This first test requires that we retrieve the film *Kill Bill* using `Siskel.new("Kill Bill")` and store it in a `movie` variable. Calling `title` on our `movie` should return `"Kill Bill: Vol. 1"`.

```ruby
# siskel.rb

class Siskel
  require 'httparty'

  attr_reader :title

  def initialize(title)
    movie = HTTParty.get("http://www.omdbapi.com/?t=#{title}")
    @title = movie["Title"]
  end
end
```

Our `Siskel` object uses HTTParty to access the OMDB API when we initialize it. We will explore this API into more detail shortly. Using the data returned, we can assign `@title` to return our movie's title.

Now that our first test has passed, uncomment the next test in `test.rb`. This new test should fail when we run our tests. Write just enough code for this test to pass. Continue this process until all tests pass.

## Using the OMDb API

The [OMDb API](http://www.omdbapi.com/) is fortunately pretty straightforward. A simple `GET` request to `"http://omdbapi.com/?t=Fargo"` will return by default a JSON object with movie data for *Fargo*. You can even test this in your browser.

```json
{
	Title: "Fargo",
	Year: "1996",
	Rated: "R",
	Released: "5 Apr 1996",
	Runtime: "98 min",
	Genre: "Crime, Drama, Thriller",
	Director: "Joel Coen, Ethan Coen",
	Writer: "Ethan Coen, Joel Coen",
	Actors: "William H. Macy, Steve Buscemi, Peter Stormare, Kristin Rudrüd",
	Plot: "Jerry Lundegaard's inept crime falls apart due to his and his henchmen's bungling and the persistent police work of the quite pregnant Marge Gunderson.",
	Language: "English",
	Country: "USA, UK",
	Awards: "Won 2 Oscars. Another 68 wins & 51 nominations.",
	Poster: "http://ia.media-imdb.com/images/M/MV5BMTgxNzY3MzUxOV5BMl5BanBnXkFtZTcwMDA0NjMyNA@@._V1_SX300.jpg",
	Metascore: "85",
	imdbRating: "8.2",
	imdbVotes: "385103",
	imdbID: "tt0116282",
	Type: "movie",
	Response: "True"
}
```

The `?` indicates the start of a query string, where we can pass any numer of key-value pairs to our request, separated by `&`s.

So if we wanted to be more specific, we could search for *Fargo* by title or year.

```sh
http://omdbapi.com/?t=Fargo&y=1996
```

The OMDb API provides us with a few different parameters we can use to add granularity to our query. You can find these all readily available in the OMDb documentation. Play around with these until you feel comfortable.

Not all APIs are as simple as OMDb. Make sure your first step when using a new API is reading through its documentation. This will likely save you tons of time down the road. If your lucky, an API will be well documented, but that's not always the case.

Now get to work!