defmodule Server.Entity do
  use Server.Web, :model

  schema "entities" do
    field :name, :string
    field :level, :integer, default: 1
    field :entity_type, :integer, default: 1
    field :gold, :integer, default: 1000
    field :experience, :integer, default: 0
    field :sex, :string, default: "male"
    field :armor_id, :integer, default: 1
    field :weapon_id, :integer, default: 1
    field :strength, :integer, default: 10
    field :endurance, :integer, default: 10
    field :attractiveness, :integer, default: 0
    field :art_url, :string
    field :location_id, :integer
    field :health, :integer, default: 0
    field :defense, :integer, default: 0

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, ])
    |> validate_required([:name, :level, :gold, :experience, :sex, :is_vendor])
  end
end
