# What is done?
- [x] Setup project
- [x] List contacts
- [x] Add contact
- [x] Edit contact
- [X] List segments
- [X] Add segment
- [X] Filter contacts by segments
- [X] Show segmentations in contact list to filter
- [X] Link do filter by segmentation in sementations list
- [X] Final tests
- [X] Deploy

# What is missing?
- Some CSS
- Security improvement (XSS, SQL Injection)

# How to run?
## Requirements
1. Install ruby (version 2.4.1)
2. Install rails

## Runningp project
```sh
gem install bundler
git clone https://github.com/hudolfhess/RubyApp
cd RubyApp
bundle install # fist time only
rails db:migrate # first time only or when schema is changed
rails server
```