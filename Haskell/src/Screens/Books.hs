module Screens.Books where

import Utils.Screen

addBookDisplay :: IO String
addBookDisplay = do
  return
    "\n=-=-=-=-=-=-=-=-=-=\nAdicionar livro\n=-=-=-=-=-=-=-=-=-=\n \
    \a) Adicionar livro\nb) Editar livro\nc) Listar livros\nd) Excluir livro\n \
    \Sua opção: "

editBookDisplay :: IO String
editBookDisplay = do
  line <-
    putOnScreenCls
      "\n=-=-=-=-=-=-=-=-=-=\nEditar livro\n=-=-=-=-=-=-=-=-=-=\n \
      \ Digite o nome do livro que deseja editar ou 'v' para voltar:"

  if line == "v"
    then return ""
    else do
      --Nota e Descrição
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
      "\n=-=-=-=-=-=-=-=-=-=\nExcluir livro\n=-=-=-=-=-=-=-=-=-=\n \
      \Digite o nome do livro que deseja excluir ou 'v' para voltar:"

  if line == "v"
    then return ""
    else do
      --deleteBook line
      putOnScreen "Seu livro foi deletado com sucesso! (Aperte Enter para continuar)"
      return ""
