# Outbound

Sends & tracks outbound emails and provides the outbound widget in oscarj

### Basic Setup

Clone repo
```
git clone git@github.com:Microryza/outbound.git
```

Install gems
```
bundle install
```

Download database
```
heroku pg:pull DATABASE_URL outbound_development
```

Run
```
bundle exec rails s
```
