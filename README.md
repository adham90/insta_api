# Setup the environment

This application requires:

- Ruby [2.2.\*, 2.3.*]
- Rails 4.2.6
- Redis 3.*

**Using RVM**

If you're using RVM then you might want to run

> $ rvm use --create --ruby-version 2.2.4@insta_api

### Installation

To get rolling, start by copying config/database.yml.copy into config/database.yml

> $ cp config/database.yml.copy config/database.yml

And update the database configuration settings according to your environment, then bin/setup

> $ cd insta_api/<br>
> $ bin/setup

After setup finish run the server.

> $ foreman start

run test.

> $ rspec
