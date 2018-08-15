defmodule HomeWeb.StoreChannel do
  use HomeWeb, :channel
  alias Home.Store

  def join("store", _payload, socket) do
    {:ok, Store.state(), socket}
  end

  def handle_in("dispatch", action, socket) do
    [namespace, type] =
      action["type"]
      |> String.split("/")
      |> Enum.map(&String.to_existing_atom/1)

    payload = Map.delete(action, "type")

    result = Store.dispatch({namespace, type}, payload)

    {:reply, result, socket}
  end
end
