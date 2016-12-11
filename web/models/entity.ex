defmodule Server.Entity do
  use Server.Web, :model

  alias Server.Repo

  schema "entities" do
    field :name, :string
    field :level, :integer, default: 1
    field :entity_type, :integer, default: 1
    field :gold, :integer, default: 1000
    field :experience, :integer, default: 0
    field :sex, :string, default: "male"
    field :armor, :string, default: "Armor"
    field :weapon, :string, default: "Stick"
    field :strength, :integer, default: 1
    field :endurance, :integer, default: 1
    field :attractiveness, :integer, default: 0
    field :art_url, :string
    field :location_id, :integer
    field :health, :integer, default: 25
    field :defense, :integer, default: 1
    field :s_hit, :string, default: "gethit1m"
    field :s_atk, :string, default: "stab"
    field :s_die, :string, default: "death_m"
    field :s_miss, :string, default: "stab"


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

  def spawn(player_level, player_experience, player_endurance) do
    min = player_level - 1
    max = player_level + 5
    choices = Repo.all from e in __MODULE__,
      select: [:name, :level, :gold, :experience, :armor, :weapon, :health, :defense,
               :s_hit, :s_atk, :s_die, :s_miss],
      where: e.level >= ^min,
      where: e.level <= ^max

    Enum.random(choices)
  end
end
