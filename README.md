# Elixir Storyblok Service

A service that fetches, parses and exposes data from Storyblok as JSON via a REST API.

## Running locally

1. Install Elixir
2. Create `config/config.exs` to store environment variables
3. Run `mix deps.get` to fetch dependencies
4. Run `iex -S mix` in project root to start service

API is exposed at http://localhost:4000/api

## Endpoints

#### GET /api/specialists

Fetches specialist data from specialist gallery in Storyblok.
On `200 OK` it returns: `{ "specialists": [ data ] }`
