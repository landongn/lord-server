defmodule Server.Armor do
  use Server.Web, :model

  schema "armor" do
    field :name, :string
    field :defense, :integer
    field :cost, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :defense, :cost])
    |> validate_required([:name, :defense, :cost])
  end
end
