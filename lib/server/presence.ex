defmodule Server.Presence do
  use Phoenix.Presence, otp_app: :server,
                        pubsub_server: Server.PubSub
  alias Server.Character
  require Ecto.Query
  alias Server.Repo

  def fetch(_topic, entries) do
    ents = Map.keys(entries)
    query = Ecto.Query.from(c in Character,
      where: c.name in ^ents,
      select: c.name)

    characters = query |> Repo.all
  end
end