defmodule Game.Feeds.ChangefeedSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, [name: __MODULE__])
  end

  def init(:ok) do
    # children = [
    #   worker(
    #     Game.Feeds.RoomFeed,
    #     [Game.Database, [name: Game.Feeds.RoomFeed]]
    #   ),
    #   supervisor(Game.Feeds.RoomFeedSup, []),
    # ]

    # supervise(children, strategy: :one_for_one)

    children = [
      %{
        id: Game.Feeds.RoomFeed,
        start: {Game.Feeds.RoomFeed, :start_link, [Game.Database, [[port: 28015, host: "localhost", db: "game"]]]}
      },
      # %{
      #   id: Game.Feeds.RoomFeedSup,
      #   start: {Game.Feeds.RoomFeedSup, :start_link, []}
      # },
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
