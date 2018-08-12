defmodule HomeWeb.StoreChannel do
  use HomeWeb, :channel
  require Logger

  def join("store", _payload, socket), do: {:ok, socket}

  def handle_in("server_commit", mutation, socket) do
    Logger.debug(fn ->
      "Committing mutation:\n#{inspect(mutation)}\n"
    end)

    # FIXME: commit mutation

    {:noreply, socket}
  end

  def handle_in("server_dispatch", action, socket) do
    Logger.debug(fn ->
      "Performing action:\n#{inspect(action)}\n"
    end)

    # FIXME: perform action
    result = %{FIXME: true}

    {:reply, {:ok, result}, socket}
  end
end
