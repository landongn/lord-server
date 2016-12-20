defmodule Server.Skill do
  use Server.Web, :model

  schema "skills" do
    field :name, :string
    field :attack_message, :string
    field :class_id, :integer
    field :damage_modifier, :integer
    field :mana_cost, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :attack_message, :class_id, :damage_modifier, :mana_cost])
    |> validate_required([:name, :attack_message, :class_id, :damage_modifier, :mana_cost])
  end
end
