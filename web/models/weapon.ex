defmodule Server.Weapon do
  use Server.Web, :model

  schema "weapons" do
    field :name, :string
    field :damage, :integer
    field :cost, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :damage, :cost])
    |> validate_required([:name, :damage, :cost])
  end
end
