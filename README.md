# Simple search ([Live Demo](https://adjust-simplesearch.herokuapp.com/))

![Build](https://github.com/aderyabin/simple_search/actions/workflows/rspec.yml/badge.svg)


## Installation

Install [dip](https://github.com/bibendi/dip) [gem](https://evilmartians.com/chronicles/reusable-development-containers-with-docker-compose-and-dip):

    $ gem install dip


Create env files:

    $ echo "DATABASE_URL=postgres://postgres:postgres@postgres/simple_search_development" > env.development
    $ echo "DATABASE_URL=postgres://postgres:postgres@postgres/simple_search_test" > env.test

Run provisioning:

    $ dip provision


Start server:

    $ dip rails s



## Testing

Run `dip rspec` to run the tests


## Built With

* Rails 3.1.0
* Rails 7
* Postgres 14
* Docker
* `dip` gem
