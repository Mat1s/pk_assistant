web: bin/rails server -p $PORT -e $RAILS_ENV
bundle exec rake jobs:work
pokemonworker: bundle exec sidekiq -c 2