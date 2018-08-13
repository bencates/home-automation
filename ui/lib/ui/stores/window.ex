defmodule Home.Stores.Window do
  use Home.Store, namespace: :window

  def state do
    %{
      windows: [%{
        id: :den_window,
        name: "Den Window",
        position: 0
      }]
    }
  end

  defmodule Mutations do
    def set_window(state, %{ id: id, position: position }) do
      IO.inspect(state)
      state
    end
  end

  defmodule Actions do
    def set_window(_state, %{ id: id, position: position }) do
      {:ok, %{}}
    end
  end
end
