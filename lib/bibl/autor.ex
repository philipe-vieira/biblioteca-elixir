defmodule Bibl.Autor do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:nome]

  schema "autor" do
    field :nome, :string
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
