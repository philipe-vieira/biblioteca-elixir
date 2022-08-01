defmodule Bibl.Escrita do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bibl.Autor
  alias Bibl.Publicacao

  @fields [:ordem, :autor_id, :publicacao_id]

  schema "escrita" do
    field :ordem, :integer

    belongs_to :autor, Autor
    belongs_to :publicacao, Publicacao
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required([:autor_id, :publicacao_id])
  end
end
