# defmodule Game.Feeds.RoomFeedSup do
#   use Supervisor

#   def start_link do
#     Supervisor.start_link(__MODULE__, :ok, [name: __MODULE__])
#   end

#   def start_child(db, pid, id) do
#     Supervisor.start_child(__MODULE__, [{db, pid, id}])
#   end

#   def init(:ok) do
#     # children = [
#     #   worker(Game.Feeds.RoomFeed, [], restart: :temporary),
#     # ]

#     # supervise(children, strategy: :simple_one_for_one)

#     children = [
#       %{
#         id: Game.Feeds.RoomFeed,
#         start: {Game.Feeds.RoomFeed, :start_link, []}
#       }
#     ]

#     {:ok, _pid} = Supervisor.start_link(children, strategy: :one_for_one)
#   end
# end
