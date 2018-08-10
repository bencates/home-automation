# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ui,
  namespace: Home

# Configures the endpoint
config :ui, HomeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wNlXZ8jyA8JLXDpst2uvl/PFz2myOJiHXhsBr2mUQx6S1PiAHp52XW6M3VAp0siX",
  render_errors: [view: HomeWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Home.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
