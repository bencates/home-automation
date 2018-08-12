defmodule Home.Store do
  import HomeWeb.Endpoint, only: [broadcast!: 3]

  def broadcast_commit(mutation, payload) when is_atom(mutation),
    do: payload |> Map.put(:type, mutation) |> broadcast_commit

  def broadcast_commit(mutation) when is_atom(mutation),
    do: broadcast_commit(%{type: mutation})

  def broadcast_commit(mutation) do
    broadcast!("store", "commit", mutation)
  end

  def broadcast_dispatch(action, payload) when is_atom(action),
    do: payload |> Map.put(:type, action) |> broadcast_dispatch

  def broadcast_dispatch(action) when is_atom(action),
    do: broadcast_dispatch(%{type: action})

  def broadcast_dispatch(action) do
    broadcast!("store", "dispatch", action)
  end
end
