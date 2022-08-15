defmodule GameWeb.Models.Room do
  @derive Jason.Encoder

  defstruct name: nil, players: [], max_players: 5, status: "waiting"
end
