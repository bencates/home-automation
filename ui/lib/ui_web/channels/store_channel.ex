defmodule HomeWeb.StoreChannel do
  use HomeWeb, :channel
  alias Home.Store

  def join("store", _payload, socket), do: {:ok, socket}

  def handle_in("dispatch", action, socket) do
    type = namespaced(action["type"])
    result = Store.dispatch(type, action)

    {:reply, result, socket}
  end

  defp namespaced(name) do
    [namespace, type] =
      name
      |> String.split("/")
      |> Enum.map(&String.to_existing_atom/1)

    {namespace, type}
  end
end
