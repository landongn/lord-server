defmodule Server.Update do
  use Server.Web, :model

  schema "updates" do
    field :posted_by, :string
    field :body, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:posted_by, :body])
    |> validate_required([:posted_by, :body])
  end
end
