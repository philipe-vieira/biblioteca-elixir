defmodule Bibl do
  import Ecto.Query

  alias Bibl.Autor
  alias Bibl.Escrita
  alias Bibl.Publicacao
  alias Bibl.Requisicao
  alias Bibl.Requisitante
  alias Bibl.Repo

  def main do
    main(nil)
  end

  def main(opt) when opt == "0" do
    IO.puts "Saindo..."
    :ok
  end

  def main(opt) when opt != "0" do
    IO.puts "---- Menu ----\n" <>
    "1 - Relacionar as publicações de um determinado autor;\n" <>
    "2 - Relacionar os empréstimos de um determinado requisitante;\n" <>
    "3 - Mostrar a situação de uma determinada publicação;\n" <>
    "4 - Relacionar as publicações emprestadas de um determinado autor;\n" <>
    "5 - Relacionar o total de empréstimos de uma determinada publicação;\n" <>
    "0 - sair"
    option = IO.gets "=> "
    option = String.trim(option)
    chosen_option(option)
    IO.puts "\n\n"
    main(option)
  end

  defp chosen_option(option) when option == "1" do
    Repo.all(Autor)
    |> Enum.map(fn autor -> IO.puts "#{autor.id} - #{autor.nome}" end)
    autor_id = IO.gets "Digite o id do autor desejado -> "
    autor_id = String.trim(autor_id)

    IO.puts "\n\n----- RELACAO DE PUBLICACOES DO AUTOR(A) -----"
    Repo.all(from esc in Escrita, where: esc.autor_id == ^autor_id)
    |> Repo.preload([:publicacao])
    |> Enum.map(fn pub -> IO.puts "#{pub.publicacao.nome}, #{pub.publicacao.ano}; " <>
      "Situacao #{pub.publicacao.situacao}(#{pub.publicacao.quantidade})" end)
  end

  defp chosen_option(option) when option == "2" do
    Repo.all(Requisitante)
    |> Enum.map(fn req -> IO.puts "#{req.id} - #{req.nome}" end)
    req_id = IO.gets "Digite o id do requisitante desejado -> "
    req_id = String.trim(req_id)

    IO.puts "\n\n----- RELACAO DE EMPRESTIMOS DO REQUISITANTE -----"
    requisitante = Repo.preload(Repo.get(Requisitante, req_id), [:requisicoes])
    requisitante.requisicoes
    |> Repo.preload([:publicacao])
    |> Enum.map(fn emp -> IO.puts "#{emp.publicacao.nome}, #{emp.publicacao.ano}; " <>
      "Data Requisicao: #{emp.data_requisicao}, " <>
      "Data Entrega: #{emp.data_entrega}" end)
  end

  defp chosen_option(option) when option == "3" do
    Repo.all(Publicacao)
    |> Enum.map(fn pub -> IO.puts "#{pub.id} - #{pub.nome}, #{pub.ano}" end)
    pub_id = IO.gets "Digite o id do publicacao desejado -> "
    pub_id = String.trim(pub_id)

    IO.puts "\n\n----- SITUACAO DA PUBLICACAO -----"
    publicacao = Repo.get(Publicacao, pub_id)
    IO.puts "#{publicacao.nome}, #{publicacao.ano}; Situação: #{publicacao.situacao}(#{publicacao.quantidade})"
  end

  defp chosen_option(option) when option == "4" do
    Repo.all(Autor)
    |> Enum.map(fn autor -> IO.puts "#{autor.id} - #{autor.nome}" end)
    autor_id = IO.gets "Digite o id do autor desejado -> "
    autor_id = String.trim(autor_id)

    IO.puts "\n\n----- RELACAO DE PUBLICACOES EMPRESTADAS DO AUTOR(A) -----"
    pubs = Repo.all(from e in Escrita, where: e.autor_id == ^autor_id, select: e.publicacao_id)
    Repo.all(from req in Requisicao,
      join: pub in Publicacao, on: pub.id == req.publicacao_id,
      join: r in Requisitante, on: r.id == req.requisitante_id,
      where: req.publicacao_id in ^pubs,
      select: %{id: req.id, data: req.data_requisicao, publicacao: pub.nome, ano: pub.ano, requisitante: r.nome})
    |> Enum.map(fn emp -> IO.puts "#{emp.publicacao}, #{emp.ano}; Em #{emp.data} Por #{emp.requisitante}" end)
  end

  defp chosen_option(option) when option == "5" do
    Repo.all(Publicacao)
    |> Enum.map(fn pub -> IO.puts "#{pub.id} - #{pub.nome}" end)
    pub_id = IO.gets "Digite o id do publicacao desejado -> "
    pub_id = String.trim(pub_id)

    [qnt] = Repo.all(from e in Requisicao, where: e.publicacao_id == ^pub_id, select: count(e.id))

    IO.puts "\n\nTotal de emprestimos = #{qnt}"
  end

  defp chosen_option(option) when option == "0" do
    "Saindo..."
  end

  defp chosen_option(_option) do
    IO.puts "Opcao Invalida!"
  end
end
