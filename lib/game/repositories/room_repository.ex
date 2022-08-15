defmodule Game.RoomRepository do
  alias RethinkDB.Query
  alias Game.Database

  def create_room(room) do
    data = Map.from_struct(room)

    result = Query.table("rooms")
    |> Query.insert(data)
    |> Database.run

    result.data
  end

  def get_by_id(id) do
    result = Query.table("rooms")
    |> Query.get(id)
    |> Database.run

    IO.inspect result
    result.data
  end

  def get_all do
    result = Query.table("rooms")
    |> Database.run

    result.data
  end

  def join_player(room_id, player) do
    result = Query.table("rooms")
    |> Query.get(room_id)
    |> Database.run

    room = result.data

    new_room = %{room | "players" => [player | room["players"]]}

    Query.table("rooms")
    |> Query.update(new_room)
    |> Database.run
  end

  def start_game(room_id) do
    result = Query.table("rooms")
    |> Query.get(room_id)
    |> Database.run

    room = result.data

    new_room = %{room | "status" => "started"}

    Query.table("rooms")
    |> Query.update(new_room)
    |> Database.run
  end

  def update_room(room) do
    Query.table("rooms")
    |> Query.update(room)
    |> Database.run
  end
end
