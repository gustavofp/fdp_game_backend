defmodule GameWeb.RoomController do
  use GameWeb, :controller
  alias Game.RoomRepository
  alias GameWeb.Models.Room

  def create(conn, %{"room_name" => room_name, "host_player" => %{ "name" => host_player_name}}) do
    %Room{
      name: room_name,
      players: [%{ name: host_player_name }]
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

    send_resp(conn, :ok, "")
  end

  def join(conn, %{"id" => room_id, "player" => player}) do
    _room = RoomRepository.join_player(room_id, player)

    send_resp(conn, :ok, "")
  end
end
