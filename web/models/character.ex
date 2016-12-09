defmodule Server.Character do
  use Server.Web, :model

  schema "characters" do
    field :name, :string
    field :level, :integer, default: 1
    field :experience, :integer, default: 0
    field :gold, :integer, default: 0
    field :gems, :integer, default: 0
    field :is_alive, :boolean, default: false
    field :health, :integer, default: 25
    field :defense, :integer, default: 0
    field :is_admin, :boolean, default: false
    field :sex, :string, default: "male"
    field :attractiveness, :integer, default: 1
    field :married, :boolean, default: false
    belongs_to :armor, Server.Armor
    belongs_to :weapon, Server.Weapon
    belongs_to :class, Server.Class
    belongs_to :player, Server.Player

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :level, :experience, :gold, :gems, :is_alive, :health, :defense, :is_admin, :sex, :attractiveness, :married])
    |> validate_required([:name, :level, :experience, :gold, :gems, :is_alive, :health, :defense, :is_admin, :sex, :attractiveness, :married])
  end

  def new_character(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :player_id, :class_id])
    |> validate_required([:name, :class_id, :player_id])
    |> cast_assoc(:class, required: true)
    |> cast_assoc(:player, required: true)
  end
end
