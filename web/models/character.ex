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
    field :strength, :integer, default: 1
    field :endurance, :integer, default: 10
    field :married, :boolean, default: false
    field :armor_id, :integer, default: 1
    field :weapon_id, :integer, default: 1
    field :luck, :integer, default: 1
    field :reputation, :integer, default: 0
    field :class_id, :integer
    field :player_id, :integer


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
    |> validate_required([:name, :player_id, :class_id])
  end

  def battle_report(struct, params \\ %{}) do
    struct
    |> cast(params, [:health, :gems, :gold, :experience, :level, :is_alive])
    |> validate_required([:health, :gems, :gold, :experience, :level, :is_alive])
  end

  def zone(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :level, :experience, :gold, :gems, :is_alive, :health, :defense, :strength, :endurance, :luck ])
    |> validate_required([:name, :level, :experience, :gold, :gems, :is_alive, :health, :defense, :strength, :endurance, :luck])
  end
end
