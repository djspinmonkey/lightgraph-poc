# LightGraph Proof-Of-Concept

This is a "cheap and cheerful" throwaway version of a GraphQL API Gateway, slapped together in a few hours just to see what a GraphQL facade of our APIs would even look like. This version is written in Rails using ruby-graphql, purely because that is the framework in which I personally can most quickly slap together a POC. I imagine a real version would be written in Go, probably using the Wundergraph library.

## How to run the LightGraph POC locally

Make sure you have defined these environment variables:

```shell
export LS_TOKEN=[your api key]
export LS_PUBLICAPI_URL="https://api.staging.lightstep.com/public/v0.2" # Or whatever you prefer
```

Then, check out this POC code, navigate to the project's root directory, and run the server:

```shell
bundle install  # only needed the first time, to install dependencies
rails server
```

## How to query the LightGraph POC

There's a built-in web ui for building and submitting queries out of the box, called GraphiQL (pronounced "graphical"... because it's a graphical UI... for GraphQL... GET IT?? :smiley:). By default, the service binds to port 3000, so you'd be able to reach GraphiQL at [http://localhost:3000/graphiql](http://localhost:3000/graphiql). You can also use curl (or your http client of choice) to send GraphQL requests directly to the API, as so:

```shell
curl 'http://localhost:3000/graphql' \
  -H 'Content-Type: application/json' \
  -d '{"query":"{organization(id:\"LightStep\") { id name projects { id } } }"}'
```
