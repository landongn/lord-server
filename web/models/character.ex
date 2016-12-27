defmodule Server.Character do
  use Server.Web, :model
  require Logger

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
    field :mana,:integer, default: 25
    field :endurance, :integer, default: 10
    field :defense, :integer, default: 1
    field :strength, :integer, default: 5
    field :luck, :integer, default: 1
    field :banked_gold, :integer, default: 0

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

  def buy_weapon(struct, params \\ %{}) do
    struct
    |> cast(params, [:weapon_id, :gold])
    |> validate_required([:gold, :weapon_id])
  end

  def buy_armor(struct, params \\ %{}) do
    struct
    |> cast(params, [:armor_id, :gold])
    |> validate_required([:gold, :armor_id])
  end

  def defeat_master(struct, params \\ %{}) do
    struct
    |> cast(params, [:m_health, :level, :health, :strength, :defense, :endurance, :mana, :reputation])
    |> validate_required([:m_health, :level, :health, :strength, :defense, :endurance, :mana, :reputation])
  end

  def master_fail(struct, params \\ %{}) do
    struct |> cast(params, [:health]) |> validate_required([:health])
  end

  def buy_red_gem(struct, params \\ %{}) do
    struct
    |> cast(params, [:strength, :gems])
    |> validate_required([:strength, :gems])
  end

  def buy_green_gem(struct, params \\ %{}) do
    struct
    |> cast(params, [:health, :m_health, :gems])
    |> validate_required([:health, :m_health, :gems])
  end

  def buy_blue_gem(struct, params \\ %{}) do
    struct
    |> cast(params, [:defense, :gems])
    |> validate_required([:defense, :gems])
  end
end
