defmodule HomeWeb.StoreChannel do
  use HomeWeb, :channel
  alias Home.Store

  def join("store", _payload, socket), do: {:ok, socket}

  def handle_in("server_commit", mutation, socket) do
    Store.commit(mutation["type"], mutation)

    {:noreply, socket}
  end

  def handle_in("server_dispatch", action, socket) do
    result = Store.dispatch(action["type"], action)

    {:reply, result, socket}
  end
end
