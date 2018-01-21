# Connect Four

A game of Connect 4 made with a Rails 5 and React (webpacker gem)

A very rudimentary UI, but allows either local 2 player games, single-player games against an easy bot (Bob), or a hard AI (Alice)

A playable version deployed on heroku can also be found [here](https://hfs-connect-4.herokuapp.com/). Games are persisted to a database and can be loaded if you know the game ID (shown at the bottom of all games)

* Ruby version

  2.4.2

* System dependencies
  - Ruby
  - Node
  - Postgresql
  - bundler gem

* To run locally

  - Either run `gem install foreman` and then run `foreman start -f Procfile.dev -p 3000` 
  - Or use heroku `heroku local -f Procfile.dev -p 3000`

* How to run the test suite

  `rake`

## Todo:

Need to finish writing tests. I should really test individual methods instead of testing the controller because as I have it now each test is actually testing lots methods 
