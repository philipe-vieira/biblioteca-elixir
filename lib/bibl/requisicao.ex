defmodule Bibl.Requisicao do
  use Ecto.Schema
  import Ecto.Changeset

  alias Bibl.Requisitante
  alias Bibl.Publicacao

  @fields [:requisitante_id, :publicacao_id, :data_requisicao, :data_entrega]

  schema "requisicao" do
    field :data_requisicao, :date
    field :data_entrega, :date

    belongs_to :requisitante, Requisitante
    belongs_to :publicacao, Publicacao
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required([:requisitante_id, :publicacao_id, :data_requisicao])
  end
end
