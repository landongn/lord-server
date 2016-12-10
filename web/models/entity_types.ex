defmodule Server.EntityTypes do
  use Server.Web, :model

  schema "entity_types" do
    field :name, :string
    field :can_flee, :boolean, default: false
    field :invuln, :boolean, default: false
    field :description, :string, default: ""
    field :player_kills_to_date, :integer, default: 0
    field :player_murders_to_date, :integer, default: 0
    field :gold_invested_into_econ, :integer, default: 0

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end