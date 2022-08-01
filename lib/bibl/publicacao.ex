defmodule Bibl.Publicacao do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bibl.Editora
  alias Bibl.PalavraChave

  @fields [:nome, :ano, :editora_id, :quantidade, :situacao]

  schema "publicacao" do
    field :nome, :string
    field :ano, :integer
    field :quantidade, :integer
    field :situacao, :string

    belongs_to :editora, Editora
    has_many :palavra_chave, PalavraChave
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required([:nome, :ano, :quantidade])
  end
end
