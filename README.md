# README

Project requires:

Ruby 2.3.3
Redis
PostgreSQL
Modern browser

bundle exec rake db:create db:migrate db:seed

bundle exec rspec spec

deployed on heroku
https://ancient-shelf-98201.herokuapp.com

1) Register
2) Choose a room
3) Type something
4) Check out the API LiveDoc: https://ancient-shelf-98201.herokuapp.com/swagger
5) Add some messages via LiveDoc and check out the room again
6) Add URIs to websites or images to your message
7) Be Happy