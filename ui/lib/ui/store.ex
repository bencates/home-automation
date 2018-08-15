defmodule Home.Store do
  alias HomeWeb.Endpoint

  @stores %{
    window: Home.Stores.Window
  }

  defmacro __using__(namespace: namespace) do
    quote do
      alias Home.Store

      def commit(type, payload \\ %{}) do
        Store.commit({unquote(namespace), type}, payload)
      end

      def dispatch(type, payload \\ %{}) do
        Store.dispatch({unquote(namespace), type}, payload)
      end
    end
  end

  def commit({namespace, type}, payload \\ %{}) do
    state = state(namespace)
    {:ok, new_state} = namespaced_call(namespace, Mutations, type, [state, payload])
    set_state(namespace, new_state)
  end

  def dispatch({namespace, type}, payload \\ %{}) do
    state = state(namespace)
    {:ok, result} = namespaced_call(namespace, Actions, type, [state, payload])
    result
  end

  defp namespaced_call(namespace, module_type, function, args) do
    # Find the base module for the provided namespace
    with {:ok, base_module} <- Map.fetch(@stores, namespace),

         # Form the namespaced module name
         module_name <- Module.concat(base_module, module_type),

         # Ensure the resulting module name is a real module
         {:module, module} <- Code.ensure_loaded(module_name),

         # Ensure the requested function/arity pair is a real function in the
         # module
         true <- function_exported?(module, function, length(args)) do
      # Call the function in the namespaced module
      {:ok, apply(module, function, args)}
    else
      :error -> {:error, :no_namespace}
      {:error, _} -> {:error, :no_module}
      false -> {:error, :no_function}
    end
  end

  def state do
    Enum.map(@stores, fn {namespace, _} ->
      {namespace, state(namespace)}
    end)
    |> Enum.into(%{socket_connected: true})
  end

  def state(namespace) do
    {:ok, store} = :dets.open_file(:store, [])

    state =
      case :dets.lookup(store, namespace) do
        [] -> @stores[namespace].state()
        [{^namespace, state}] -> state
      end

    :dets.close(store)

    state
  end

  defp set_state(namespace, state) do
    {:ok, store} = :dets.open_file(:store, [])

    old_state =
      case :dets.lookup(store, namespace) do
        [] -> @stores[namespace].state()
        [{^namespace, state}] -> state
      end

    :dets.insert(store, {namespace, state})

    :dets.close(store)

    patch = MapDiff.diff(%{namespace => old_state}, %{namespace => state})

    Endpoint.broadcast!("store", "patch_state", patch)
  end
end
