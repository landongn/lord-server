defmodule Server.EntityTypes do
  use Server.Web, :model

  schema "entity_types" do
    field :name, :string
    field :art_url, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :art_url])
    |> validate_required([:name, :art_url])
  end
end
