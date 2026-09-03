# Bomba

Repositório do livro do time, retirado do Kactl. 
Já está no padrão para a nacional (25 páginas). 

Veja [bomba.pdf](./bomba.pdf) para a versão atual e [content/](./content/) para o código-fonte bruto.

## Regras

Os algoritmos da Bomba devem ser: úteis, curtos, suficientemente rápidos, bem testados, e se relevante, legíveis e fáceis de modificar.
Eles *não* devem ser excessivamente genéricos, já que o código é digitado manualmente e isso só adiciona overhead.
Por questões de espaço, também excluímos algoritmos muito comuns/simples (ex.: Dijkstra), ou muito incomuns (matching geral com pesos).

## Personalizando

`content/bomba.tex` é o arquivo principal da Bomba, e pode ser editado para mudar o nome do time, logo, destaque de sintaxe, etc.
Ele importa arquivos `chapter.tex` de cada um dos subdiretórios de `content/`, que definem o conteúdo de cada capítulo.
Estes incluem código-fonte, texto e matemática na forma de LaTeX.
Para adicionar/remover código de um capítulo, adicione/remova a linha `\bombaimport` correspondente do arquivo `chapter.tex`.
Para um alinhamento melhor você pode querer inserir comandos `\hardcolumnbreak`, `\columnbreak` ou `\newpage`,
embora isso geralmente só seja feito antes de competições importantes, e não na branch principal.
Os algoritmos que não estão incluídos no pdf ficam comentados em `chapter.tex`.

Para construir a Bomba, digite `make bomba` (ou `make fast`) em uma máquina \*nix -- isso vai atualizar o `bomba.pdf`.
(Windows também pode funcionar, mas não foi testado.) `doc/README` tem mais algumas notas sobre isso.

Dicas:
1. Confira o que é excluído por padrão rodando `make showexcluded`.
A configuração padrão é escolhida para ser um equilíbrio razoável para iniciantes
e times avançados.
2. Aproveite o hashing ao digitar esses algoritmos. Cada
algoritmo tem um hash MD5 de 6 caracteres no canto superior direito. Esse hash pode ser
gerado usando `hash.sh` ou o comando `:Hash` do `.vimrc`. O
hashing ignora espaços em branco e comentários.

## Estilo de código

A Bomba usa um estilo de código relativamente conciso, com um punhado de macros/typedefs definidos no
[template](./content/contest/template.cpp) que ajudam a encurtar o código.
A largura de linha é de 63 caracteres, com tabs para indentação (tab = 2 espaços no pdf).

Cada algoritmo contém um cabeçalho com o autor do código, a data em que
foi adicionado, uma descrição do algoritmo, seu status de teste, e preferencialmente também
fonte, licença e complexidade de tempo.

O bomba.pdf deve ser mantido em 25 páginas + capa.
Ocasionalmente o bomba.pdf gerado é commitado no repositório por conveniência, mas não com muita frequência porque isso deixa as operações do git mais lentas.

## Testes

A Bomba busca um alto nível de confiança na corretude dos algoritmos.
Os testes são feitos tanto em juízes online quanto (para algoritmos mais novos) com stress tests
que comparam a saída com um algoritmo mais ingênuo para uma grande quantidade de casos gerados aleatoriamente.
Esses testes vivem no diretório `stress-tests`, e são rodados com CI a cada commit. O CI também verifica que todos os headers compilam (exceto por uma lista de exclusão em `docs/scripts/skip_headers`) e que o latex compila.

`old-unit-tests` contém alguns testes unitários quebrados, tocados pela última vez há cerca de dez anos.

## Licença

Como é comum em programação competitiva, a situação de licenciamento é um pouco incerta.
Muitos arquivos-fonte estão marcados com licença (tentamos usar
[CC0](https://creativecommons.org/share-your-work/public-domain/cc0/)), mas muitos também não estão.
Presumivelmente boa vontade deve ser assumida de outros autores, no entanto, e em muitos casos permissão não deveria ser necessária já que o código não é distribuído.
Para ajudar a rastrear as coisas, fontes e autores são anotados nos arquivos-fonte.

Tudo em `stress-tests` é implicitamente CC0, exceto implementações de referência retiradas da Internet.
