defmodule Server.Post do
  use Server.Web, :model

  schema "posts" do
    field :location, :integer
    field :posted_by, :string
    field :body, :string
    field :reply_to, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:location, :posted_by, :body])
    |> validate_required([:location, :posted_by, :body])
  end
end
