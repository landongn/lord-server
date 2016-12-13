defmodule Server.Character do
  use Server.Web, :model

  schema "characters" do
    #book keeping
    field :class_id, :integer
    field :player_id, :integer
    field :armor_id, :integer, default: 2
    field :weapon_id, :integer, default: 2

    field :is_alive, :boolean, default: true
    field :is_admin, :boolean, default: false
    field :sex, :string, default: "male"

    field :name, :string

    # combat / encounter mechanics
    field :level, :integer, default: 1
    field :experience, :integer, default: 0
    field :gold, :integer, default: 100
    field :gems, :integer, default: 0
    field :m_health, :integer, default: 25
    field :m_mana, :integer, default: 25
    field :health, :integer, default: 25
    field :endurance, :integer, default: 10
    field :defense, :integer, default: 3
    field :strength, :integer, default: 10
    field :luck, :integer, default: 1

    # uhhh
    field :married, :boolean, default: false

    # notoriety
    field :reputation, :integer, default: 0
    field :attractiveness, :integer, default: 1

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

  def healer_full(struct, params \\ %{}) do
    struct
    |> cast(params, [:health, :gold])
    |> validate_required([:health, :gold])
  end

  def zone(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :level, :experience, :gold, :gems, :is_alive, :health, :defense, :strength, :endurance, :luck ])
    |> validate_required([:name, :level, :experience, :gold, :gems, :is_alive, :health, :defense, :strength, :endurance, :luck])
  end
end
