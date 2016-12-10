defmodule Server.News do
  use Server.Web, :model

  schema "news" do
    field :body, :string
    field :posted_by, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:body])
    |> validate_required([:body])
  end
end
