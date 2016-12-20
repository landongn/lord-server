defmodule Server.Level do
  use Server.Web, :model

  schema "levels" do
    field :minimum, :integer
    field :class_id, :integer
    field :str, :integer
    field :def, :integer
    field :health, :integer
    field :endurance, :integer
    field :rank, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:minimum, :class_id, :str, :def, :health, :endurance, :rank])
    |> validate_required([:minimum, :class_id, :str, :def, :health, :endurance, :rank])
  end
end
