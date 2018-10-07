# MatchFetcher

## About a project

The application fetches API providers and persists results to the Postgres DB.

The main features:

* you can add another provider by:
  * adding configure attributes in MatchFetcher module
  * adding type module like MatchFetcher.FastBall module
* you can change fetch period in configs
* it uses additional path variables for offset limiting provider response

## Setup

```sh
mix deps.get
```

Create DB and run migrations:
```sh
mix ecto.create && mix ecto.migrate
```

## Run the project

```sh
MIX_ENV=<environment> mix run --no-halt
```

## Run tests

```sh
mix test
```
