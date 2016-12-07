defmodule Server.Entity do
  use Server.Web, :model

  schema "entities" do
    field :name, :string
    field :level, :integer
    field :gold, :integer
    field :experience, :integer
    field :sex, :string
    field :is_vendor, :boolean, default: false
    belongs_to :armor, Server.Armor
    belongs_to :weapon, Server.Weapon

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :level, :gold, :experience, :sex, :is_vendor])
    |> validate_required([:name, :level, :gold, :experience, :sex, :is_vendor])
  end
end
