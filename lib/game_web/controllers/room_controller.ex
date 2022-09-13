defmodule GameWeb.RoomController do
  use GameWeb, :controller
  alias Game.RoomRepository
  alias GameWeb.Models.Room

  def create(conn, %{"name" => name, "max_players" => max_players, "players" => players }) do
    %Room{
      name: name,
      max_players: max_players,
      players: players
    }
      |> RoomRepository.create_room

    send_resp(conn, :ok, "")
  end

  def get_by_id(conn, %{"id" => room_id}) do
    result = RoomRepository.get_by_id(room_id)

    json(conn, %{ room: result })
  end

  def get_all(conn, _playload) do
    results = RoomRepository.get_all

    json(conn, %{ rooms: results })
  end

  def start_game(conn, %{"id" => room_id}) do
    _room = RoomRepository.start_game(room_id)

    GameWeb.Endpoint.broadcast("game:lobby", "game_started", %{ room_id: room_id })

    json(conn, %{ game_id: room_id })
  end

  def join(conn, %{"id" => room_id, "player" => player}) do
    _room = RoomRepository.join_player(room_id, player)

    json(conn, %{ game_id: room_id })
  end
end
