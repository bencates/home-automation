defmodule Home.Stores.Window do
  use Home.Store, namespace: :window

  def state do
    %{
      windows: %{
        den: %{
          name: "Den Window",
          position: 50
        }
      }
    }
  end

  defmodule Mutations do
    def set_window(state, %{"id" => id, "position" => position}) do
      put_in(state, [:windows, String.to_existing_atom(id), :position], position)
    end
  end

  defmodule Actions do
    def set_window(_state, payload) do
      Home.Stores.Window.commit(:set_window, payload)

      {:ok, %{}}
    end
  end
end
