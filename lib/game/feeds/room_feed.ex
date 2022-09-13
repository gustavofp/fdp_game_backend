defmodule Game.Feeds.RoomFeed do
  use RethinkDB.Changefeed
  alias Game.RoomRepository

  def start_link(opts, gen_server_opts \\ []) do
    RethinkDB.Changefeed.start_link(__MODULE__, opts, gen_server_opts)
  end

  def init(db) do
    # ref = Process.monitor(pid)
    query = RethinkDB.Query.table("rooms")
      |> RethinkDB.Query.changes

    {:subscribe, query, db, {db, nil}}
  end

  def handle_info(data, gen_event) do
    IO.puts "info"
  end

  def handle_cast(data, _) do
    IO.puts "cast"
  end

  def handle_update(data, state) do
    IO.inspect data
    IO.inspect state

    # if length(data) > 0 do
    #   register = Enum.at(data, 0)
    #   updated_room = register["new_val"]
    #   if updated_room["status"] == "started" do
    #     IO.puts "broadcast"
    #     GameWeb.Endpoint.broadcast!("game:lobby", "game_started", %{ room: updated_room })
    #   end
    # end

    results = RoomRepository.get_all

    GameWeb.Endpoint.broadcast("rooms:lobby", "feed_updated", %{ rooms: results })
    IO.puts "enviou"
    {:next, data}
  end

  def handle_call(:get, _from, data) do
    IO.puts "call"
    {:reply, data, data}
  end

  def terminate(data, info) do
    IO.puts "terminate"
  end
end
