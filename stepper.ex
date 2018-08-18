defmodule Stepper do
  use GenServer
  alias ElixirAle.GPIO

  @steps_per_rev 200

  @LOW 0
  @HIGH 1

  def init(ain1_pin, ain2_pin, bin1_pin, bin2_pin, stby_pin) do
    {:ok, ain1} = GPIO.start_link(ain1_pin, :output)
    {:ok, ain2} = GPIO.start_link(ain2_pin, :output)
    {:ok, bin1} = GPIO.start_link(bin1_pin, :output)
    {:ok, bin2} = GPIO.start_link(bin2_pin, :output)
    {:ok, stby} = GPIO.start_link(stby_pin, :output)

    GPIO.write(stby, @HIGH)

    {:ok, %{
      pins: %{
        ain1: ain1,
        ain2: ain2,
        bin1: bin1,
        bin2: bin2,
        stby: stby,
      }
      target: 0,
      current_step: :step_1,
      frequency: 10
    }, {:continue, :step_1}}
  end



  def handle_call(:disable, _from, %{pins: pins} = state) do
    GPIO.write(pins.stby, @HIGH)

    {:noreply, %{state | target: 0}}
  end

  def handle_call(:stop, _from, %{pins: pins} = state) do
    GPIO.write(pins.stby, @LOW)

    {:reply, state.target, %{state | target: 0}}
  end

  def handle_call({:step, count}, _from, %{pins: pins} = state) do
    GPIO.write(pins.stby, @LOW)

    {:noreply, %{state | target: count}, {:continue, state.current_step}}
  end

  def handle_call({:set_speed, speed_in_rpm}, _from, state) do
    frequency = round(60_000.0 / (speed_in_rpm * @steps_per_rev))

    {:noreply, %{state | frequency: frequency}, frequency}
  end



  def handle_continue(:step_1, %{pins: pins} = state) do
    GPIO.write(pins.ain1, @LOW)
    GPIO.write(pins.ain2, @HIGH)
    GPIO.write(pins.bin1, @LOW)
    GPIO.write(pins.bin2, @HIGH)

    {:noreply, %{state | current_step: :step_1}, state.frequency}
  end

  def handle_continue(:step_2, %{pins: pins} = state) do
    GPIO.write(pins.ain1, @HIGH)
    GPIO.write(pins.ain2, @LOw)
    GPIO.write(pins.bin1, @LOW)
    GPIO.write(pins.bin2, @HIGH)

    {:noreply, %{state | current_step: :step_2}, state.frequency}
  end

  def handle_continue(:step_3, %{pins: pins} = state) do
    GPIO.write(pins.ain1, @HIGH)
    GPIO.write(pins.ain2, @LOw)
    GPIO.write(pins.bin1, @HIGH)
    GPIO.write(pins.bin2, @LOW)

    {:noreply, %{state | current_step: :step_3}, state.frequency}
  end

  def handle_continue(:step_4, %{pins: pins} = state) do
    GPIO.write(pins.ain1, @LOW)
    GPIO.write(pins.ain2, @HIGH)
    GPIO.write(pins.bin1, @HIGH)
    GPIO.write(pins.bin2, @LOW)

    {:noreply, %{state | current_step: :step_4}, state.frequency}
  end



  def handle_info(:timeout, %{target: target, current_step: step} = state) do
    cond do
      target > 0 ->
        {:noreply, %{state | target: target - 1}, {:continue, next(step)}}
      target < 0 ->
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
