defmodule Bibl.Requisitante do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bibl.Requisicao

  @fields [:nome, :endereco, :telefone]

  schema "requisitante" do
    field :nome, :string
    field :endereco, :string
    field :telefone, :string

    has_many :requisicoes, Requisicao
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required([:nome])
    |> validate_length(:telefone, max: 20)
  end
end
