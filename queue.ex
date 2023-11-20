defmodule Queue do
  use GenServer

  def start_link(initial) do
    GenServer.start_link(__MODULE__, initial)
  end

  def enqueue(pid, el) do
    GenServer.cast(pid, {:push, el})
  end

  def dequeue(pid) do
    GenServer.call(pid, :pop)
  end

  def get_state(pid) do
    GenServer.call(pid, :get_state)
  end

  @impl true
  def init(initial) do
    {:ok, initial}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_call(:get_state, _from, list) do
    {:reply, list, list}
  end

  @impl true
  def handle_cast({:push, el}, list) do
    {:noreply, [el | list]}
  end
end
