defmodule Home.Store do
  alias HomeWeb.Endpoint

  def commit(type, payload \\ %{})

  def commit(type, payload) when is_binary(type) do
    try do
      commit(String.to_existing_atom(type), payload)
    rescue
      ArgumentError -> {:error, "mutation not found"}
    end
  end

  def commit(_type, _payload), do: {:error, "mutation not found"}

  def dispatch(type, payload \\ %{})

  def dispatch(type, payload) when is_binary(type) do
    try do
      dispatch(String.to_existing_atom(type), payload)
    rescue
      ArgumentError -> {:error, "mutation not found"}
    end
  end

  def dispatch(_type, _payload), do: {:error, "action not found"}

  def broadcast_commit(type, payload \\ %{}) do
    mutation = Map.put(payload, :type, type)
    Endpoint.broadcast!("store", "commit", mutation)
  end

  def broadcast_dispatch(type, payload \\ %{}) do
    action = Map.put(payload, :type, type)
    Endpoint.broadcast!("store", "dispatch", action)
  end
end
