defmodule HomeWeb.Router do
  use HomeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HomeWeb do
    pipe_through :api
  end
end
