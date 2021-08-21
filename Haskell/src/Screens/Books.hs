module Screens.Books where

addBookDisplay :: IO String
addBookDisplay = do
  return
    "\n=-=-=-=-=-=-=-=-=-=\nAdicionar livro\n=-=-=-=-=-=-=-=-=-=\n \
    \a) Adicionar livro\nb) Editar livro\nc) Listar livros\nd) Excluir livro\n \
    \Sua opção: "

editBookDisplay :: IO String
editBookDisplay = do
  return
    "\n=-=-=-=-=-=-=-=-=-=\nEditar livro\n=-=-=-=-=-=-=-=-=-=\n \
    \a) Adicionar livro\nb) Editar livro\nc) Listar livros\nd) Excluir livro\n \
    \Sua opção: "

seeBooksDisplay :: IO String
seeBooksDisplay = do
  return
    "\n=-=-=-=-=-=-=-=-=-=\nListar livros\n=-=-=-=-=-=-=-=-=-=\n \
    \a) Adicionar livro\nb) Editar livro\nc) Listar livros\nd) Excluir livro\n \
    \Sua opção: "

delBookDisplay :: IO String
delBookDisplay = do
  return
    "\n=-=-=-=-=-=-=-=-=-=\nExcluir livro\n=-=-=-=-=-=-=-=-=-=\n \
    \a) Adicionar livro\nb) Editar livro\nc) Listar livros\nd) Excluir livro\n \
    \Sua opção: "
