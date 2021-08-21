# My reading journal

O My Reading Journal é um sistema de gerenciamento de leituras para o usuário acompanhar seu desempenho e manter os livros em dia. Dessa forma, será possível adicionar livros e suas identificações, além de avaliar com uma nota e definir uma descrição para a obra. O software faz uso da [OpenLibraryAPI](https://openlibrary.org/developers/api) para obter informações sobre os livros.

## Funcionalidades
* **CRUD**<br/><br/>

  Fazendo uso do sistema de arquivos local, o usuário poderá cadastrar, editar e excluir as suas leituras, sendo as principais informações de uma leitura, as características abaixo:

  * Nome da obra
  * Nome do autor
  * Data de cadastro
  * Gênero
  * Nota
  * Descrição do usuário

* **Metas**<br/><br/>
  O usuário pode informar sua meta. Assim, sempre que entrar será informado de quantos livros faltam para alcançá-la.

* **Agrupamento de Livros por Pastas**<br/><br/>
  O usuário poderá agrupar seus livros em pastas criadas e nomeadas por ele.

* **Filtro**<br/><br/>
  Será permitido ao usuário no momento da visualização, que filtre os livros por autor, gênero ou nota.

* **Sugestão de Leituras**<br/><br/>
  O software realizará uma análise de dados de leitura do usuário para recomendar um livro que melhor lhe agrade. Dessa forma, se o usuário leu mais livros de uma categoria, mas deu uma classificação melhor a outra, um livro que contenha as duas categorias pode ser o ideal. Logo, esse será o estilo de livro recomendado.