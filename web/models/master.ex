defmodule Server.Master do
  use Server.Web, :model

  schema "masters" do
    field :rank, :integer
    field :welcome_message, :string
    field :talk_message, :string
    field :challenge_message, :string
    field :player_defeat, :string
    field :master_defeat, :string
    field :name, :string
    field :weapon, :string
    field :armor, :integer
    field :strength, :integer
    field :defense, :integer
    field :damage, :integer
    field :health, :integer, default: 0
    field :m_health, :integer, default: 0
    field :s_hit, :string
    field :s_att, :string
    field :s_miss, :string
    field :s_die, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:rank, :welcome_message, :talk_message, :challenge_message, :player_defeat, :master_defeat, :name, :weapon, :armor, :strength, :defense, :damage, :s_hit, :s_att, :s_miss, :s_die])
    |> validate_required([:rank, :welcome_message, :talk_message, :challenge_message, :player_defeat, :master_defeat, :name, :weapon, :armor, :strength, :defense, :damage, :s_hit, :s_att, :s_miss, :s_die])
  end
end
