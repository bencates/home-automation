defmodule Stepper do
  use GenServer
  alias ElixirALE.GPIO

  @steps_per_rev 200

  @low 0
  @high 1

  ##########
  # Client #
  ##########

  def start_link(pins) do
    GenServer.start_link(__MODULE__, pins, name: __MODULE__)
  end

  def disable(pid \\ __MODULE__), do: GenServer.call(pid, :disable)
  def stop(pid \\ __MODULE__), do: GenServer.call(pid, :stop)
  def step(pid \\ __MODULE__, count), do: GenServer.call(pid, {:step, count})
  def forward(pid \\ __MODULE__), do: step(pid, :forward)
  def reverse(pid \\ __MODULE__), do: step(pid, :reverse)
  def set_speed(pid \\ __MODULE__, speed_in_rpm),
    do: GenServer.call(pid, {:set_speed, speed_in_rpm})

  ##########
  # Server #
  ##########

  def init(pins) do
    {:ok, ain1} = GPIO.start_link(pins[:ain1], :output)
    {:ok, ain2} = GPIO.start_link(pins[:ain2], :output)
    {:ok, bin1} = GPIO.start_link(pins[:bin1], :output)
    {:ok, bin2} = GPIO.start_link(pins[:bin2], :output)
    {:ok, stby} = GPIO.start_link(pins[:stby], :output)

    GPIO.write(stby, @high)

    {:ok, %{
      pins: %{
        ain1: ain1,
        ain2: ain2,
        bin1: bin1,
        bin2: bin2,
        stby: stby,
      },
      target: 0,
      current_step: :step_1,
      frequency: 10
    }, {:continue, :step_1}}
  end



  def handle_call(:disable, _from, %{pins: pins} = state) do
    GPIO.write(pins.stby, @high)

    {:noreply, %{state | target: 0}}
  end

  def handle_call(:stop, _from, %{pins: pins} = state) do
    GPIO.write(pins.stby, @low)

    {:reply, state.target, %{state | target: 0}}
  end

  def handle_call({:step, count}, _from, %{pins: pins} = state) do
    GPIO.write(pins.stby, @low)

    {:noreply, %{state | target: count}, {:continue, state.current_step}}
  end

  def handle_call({:set_speed, speed_in_rpm}, _from, state) do
    frequency = round(60_000.0 / (speed_in_rpm * @steps_per_rev))

    {:noreply, %{state | frequency: frequency}, frequency}
  end



  def handle_continue(:step_1, %{pins: pins} = state) do
    GPIO.write(pins.ain1, @low)
    GPIO.write(pins.ain2, @high)
    GPIO.write(pins.bin1, @low)
    GPIO.write(pins.bin2, @high)

    {:noreply, %{state | current_step: :step_1}, state.frequency}
  end

  def handle_continue(:step_2, %{pins: pins} = state) do
    GPIO.write(pins.ain1, @high)
    GPIO.write(pins.ain2, @low)
    GPIO.write(pins.bin1, @low)
    GPIO.write(pins.bin2, @high)

    {:noreply, %{state | current_step: :step_2}, state.frequency}
  end

  def handle_continue(:step_3, %{pins: pins} = state) do
    GPIO.write(pins.ain1, @high)
    GPIO.write(pins.ain2, @low)
    GPIO.write(pins.bin1, @high)
    GPIO.write(pins.bin2, @low)

    {:noreply, %{state | current_step: :step_3}, state.frequency}
  end

  def handle_continue(:step_4, %{pins: pins} = state) do
    GPIO.write(pins.ain1, @low)
    GPIO.write(pins.ain2, @high)
    GPIO.write(pins.bin1, @high)
    GPIO.write(pins.bin2, @low)

    {:noreply, %{state | current_step: :step_4}, state.frequency}
  end



  def handle_info(:timeout, %{target: target, current_step: step} = state) do
    case target do
      :forward ->
        {:noreply, %{state | target: :forward}, {:continue, next(step)}}
      :reverse ->
        {:noreply, %{state | target: :reverse}, {:continue, prev(step)}}
      target when is_integer(target) and target > 0 ->
        {:noreply, %{state | target: target - 1}, {:continue, next(step)}}
      target when is_integer(target) and target < 0 ->
        {:noreply, %{state | target: target + 1}, {:continue, prev(step)}}
      true ->
        {:noreply, state}
    end
  end

  defp prev(:step_1), do: :step_4
  defp prev(:step_2), do: :step_1
  defp prev(:step_3), do: :step_2
  defp prev(:step_4), do: :step_3

  defp next(:step_1), do: :step_2
  defp next(:step_2), do: :step_3
  defp next(:step_3), do: :step_4
  defp next(:step_4), do: :step_1
end
