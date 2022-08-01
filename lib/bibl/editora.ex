defmodule Bibl.Editora do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bibl.Publicacao

  @fields [:nome]

  schema "editora" do
    field :nome, :string

    has_many :publicacoes, Publicacao
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
  end
end
