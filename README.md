itrackmygps.com
========

Rails4 backend for GPS Tracking

### Testing

```
% export RAILS_ENV=test
% rake db:setup
% rspec .
```


### Precompiling assets

```
% bundle exec rake tmp:cache:clear --trace
% bundle exec rake assets:clean --trace
% bundle exec rake assets:precompile --trace
```

### Deployment

Deployment via capistrano ```cap deploy```

In production, if a gem is reported missing

```bundle install --gemfile /srv/rails/itrackmygps/releases/20140530222044/Gemfile --path /srv/rails/itrackmygps/shared/bundle --deployment --quiet --without development test```