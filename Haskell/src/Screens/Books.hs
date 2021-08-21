module Screens.Books where

import Utils.Api
import Utils.Files
import Utils.Screen

addBookDisplay :: IO String
addBookDisplay = do
  line <-
    putOnScreenCls
      "\n=-=-=-=-=-=-=-=-=-=\nAdicionar livro\n=-=-=-=-=-=-=-=-=-=\n\
      \Digite o nome da obra ou 'v' para voltar:"

  -- Nome da obra
  -- Nome do autor
  -- Data de cadastro
  -- Gênero
  -- Nota
  -- Descrição
  if line == "v"
    then return ""
    else do
      -- Falta sincronizar com a API. A ideia seria colocar tudo para lowercase e comparar com a API
      -- também em lowercase (ver nome e autor e gênero)
      -- Fazer data
      nota <- putOnScreen "Digite uma nota para a obra: "
      descricao <- putOnScreen "Digite uma descrição para a obra: "

      putOnScreen "Seu livro foi adicionado com sucesso! (Aperte Enter para continuar)"
      return ""

editBookDisplay :: IO String
editBookDisplay = do
  line <-
    putOnScreenCls
      "\n=-=-=-=-=-=-=-=-=-=\nEditar livro\n=-=-=-=-=-=-=-=-=-=\n\
      \Digite o nome do livro que deseja editar ou 'v' para voltar:"

  if line == "v"
    then return ""
    else do
      nota <- putOnScreen "Digite a nova nota: "
      descricao <- putOnScreen "Digite a nova descrição: "
      --editBook line

      putOnScreen "Seu livro foi editado com sucesso! (Aperte Enter para continuar)"
      return ""

seeBooksDisplay :: IO String
seeBooksDisplay = do
  return
    "\n=-=-=-=-=-=-=-=-=-=\nListar livros\n=-=-=-=-=-=-=-=-=-=\n \
    \a) Adicionar livro\nb) Editar livro\nc) Listar livros\nd) Excluir livro\n \
    \Sua opção: "

delBookDisplay :: IO String
delBookDisplay = do
  line <-
    putOnScreenCls
      "\n=-=-=-=-=-=-=-=-=-=\nExcluir livro\n=-=-=-=-=-=-=-=-=-=\n\
      \Digite o nome do livro que deseja excluir ou 'v' para voltar:"

  if line == "v"
    then return ""
    else do
      --deleteBook line
      -- response <- getApi "http://openlibrary.org/search.json?q=the+lord+of+the+rings&page=1&limit=2"
      -- putStrLn response

      putOnScreen "Seu livro foi deletado com sucesso! (Aperte Enter para continuar)"
      return ""

editBookGoalDisplay :: IO String
editBookGoalDisplay = do
  line <-
    putOnScreenCls
      "\n=-=-=-=-=-=-=-=-=-=\nEditar meta\n=-=-=-=-=-=-=-=-=-=\n\
      \Digite a nova meta ou 'v' para voltar:"
  if line == "v"
    then return ""
    else do
      -- atualizar a nova meta
      putOnScreen "Sua meta foi alterada com sucesso! (Aperte Enter para continuar)"
      return ""