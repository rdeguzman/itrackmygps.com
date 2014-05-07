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