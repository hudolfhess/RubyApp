# What is done?
- [x] Setup project
- [x] List contacts
- [x] Add contact
- [x] Edit contact
- [X] List segments
- [X] Add segment
- [X] Filter contacts by segmentses

# What is missing?
- Final tests
- Deploy
- Some CSS
- Security improvement (XSS, SQL Injection)

# How to run?
## Requirements
1. Install ruby (version 2.4.1)
2. Install rails

## Runningp project
```sh
git clone https://github.com/hudolfhess/RubyApp
cd RubyApp
bundle install # fist time only
rails db:migrate # first time only or when schema is changed
rails server
```