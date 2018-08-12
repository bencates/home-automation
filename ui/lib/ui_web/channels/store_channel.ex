defmodule HomeWeb.StoreChannel do
  use HomeWeb, :channel
  require Logger

  def join("store", _payload, socket), do: {:ok, socket}

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (store:lobby).
  def handle_in("server_commit", mutation, socket) do
    Logger.debug(fn ->
      "Committing mutation:\n#{inspect(mutation)}\n"
    end)

    # FIXME: commit mutation

    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("server_dispatch", action, socket) do
    Logger.debug(fn ->
      "Performing action:\n#{inspect(action)}\n"
    end)

    # FIXME: perform action
    result = %{FIXME: true}

    {:reply, {:ok, result}, socket}
  end
end
