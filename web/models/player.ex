defmodule Server.Player do
  use Server.Web, :model

  schema "players" do
    field :name, :string
    field :experience, :integer, default: 0
    field :secret, :string
    field :password, :string
    field :email, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :experience, :secret, :password, :email])
    |> validate_required([:email, :password])
  end

  def new_account(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :password, :email])
    |> validate_required([:email, :password, :name])
  end


end
