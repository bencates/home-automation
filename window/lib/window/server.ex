defmodule Window.Server do
  use GenServer

  @min_position 0
  @max_position 500 # TODO: determine experimentally

  @initial_position @min_position

  @type status :: :stopped | :raising | :lowering

  @typep state :: %{
    position: non_neg_integer,
    status: status
  }

  def start_link(_) do
    GenServer.start_link(
      __MODULE__,
      [],
      name: {:global, Application.get_env(:window, :name)}
    )
  end

  ## Callbacks

  @impl true
  def init(_) do
    {:ok, %{
      position: @initial_position,
      status: :stopped
    }}
  end

  @impl true
  @spec handle_call(:status, any(), state())
    :: {:reply, {status(), 0..100}, state()}
  def handle_call(:status, _from, state) do
    normalized_position = 100 * trunc(state.position / @max_position)
    {:reply, {state.status, normalized_position}, state}
  end

  @impl true
  @spec handle_cast({:set_position, 0..100}, state()) :: {:noreply, state()}
  def handle_cast({:set_position, normalized_position}, state) do
    # FIXME: actually set the position

    {:noreply, state}
  end
end
