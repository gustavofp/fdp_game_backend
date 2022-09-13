defmodule GameWeb.GameChannel do
  use GameWeb, :channel

  @impl true
  def join("game:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  @impl true
  def join("game:" <> _game_id, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end


  @impl true
  def handle_in("game_started", payload, socket) do
    IO.puts "oi"
    IO.inspect payload
    {:reply, {:ok, payload}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
