# README

Tiny Messenger
======

Message Broadcasting

### Project requirements:

Ruby 2.3.3  
Redis  
PostgreSQL  

### **Installation Guide**
git clone git@github.com:leafmind/messenger.git  
cd messenger  
(rvm install ruby-2.3.3) if you haven't installed it already  
(optional: check out /doc folder which contains source-code-related docs)

### **Local Setup**  
bundle install  
bundle exec rake db:create db:migrate db:seed  
bundle exec rspec spec  
bundle exec rails s  

### **Heroku Setup**  
heroku login  
heroku git:remote -a ancient-shelf-98201 (paste your app name)  
git push heroku master  
heroku run bundle exec rake db:migrate  
heroku run bundle exec rake db:seed  
heroku addons:add redistogo  
heroku config --app your_app_name | grep REDISTOGO_URL  
(put this url to config/cable.yml production section)  
(Also you should change your app name in config/settings/production.yml)
git push heroku master  

deployed on heroku  
https://ancient-shelf-98201.herokuapp.com  

### **Usage Guide**
1) Register  
2) Choose a room  
3) Type something  
4) Check out the API LiveDoc: https://ancient-shelf-98201.herokuapp.com/swagger  
5) Add some messages via LiveDoc and check out the room again  
6) Add URIs to websites or images to your message  
7) Be Happy  
Goto 1 and connect several users to the 'messages' room to see live broadcasting from REST API(Swagger) in action
You can use your own API token in Swagger instead of a debug token(You will find it on the rooms page after registration)

### **LiveDoc(Swagger)**
Swagger allows you to easily interact with your app's REST API, providing flexible documentation solution at the same time  

https://ancient-shelf-98201.herokuapp.com/swagger  