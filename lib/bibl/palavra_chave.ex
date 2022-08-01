defmodule Bibl.PalavraChave do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bibl.Publicacao
  @fields [:palavra, :publicacao_id]

  @primary_key false
  schema "palavra_chave" do
    field :palavra, :string, primary_key: true

    belongs_to :publicacao, Publicacao, primary_key: true
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
  end

end
