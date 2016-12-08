defmodule Server.Character do
  use Server.Web, :model

  schema "characters" do
    field :name, :string
    field :level, :integer
    field :experience, :integer
    field :gold, :integer
    field :gems, :integer
    field :is_alive, :boolean, default: false
    field :health, :integer
    field :defense, :integer
    field :is_admin, :boolean, default: false
    field :sex, :string
    field :attractiveness, :integer
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
end
