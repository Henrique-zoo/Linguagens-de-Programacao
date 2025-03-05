# Interpretadores

No desenvolvimento dos interpretadores, algumas fases da interpretação são abstraídas, essas o lexer e o parser, explicados abaixo

- Lexer: lê uma string (o código) e separa em tokens
- Parser: lê a string de tokens e agrupa numa árvore sintática
- Type Checker: descobre o tipo de cada parte da árvore sintática e retorna uma árvore sintática anotada

A abstração dessas etapas - o chamado front end do interpretador - é feita por meio do BNF Converter (BNFC), que, a partir da definição de uma sintaxe concreta (LBNF), fornecida pela professor, produz arquivos geradores do lexer, do parser e um esqueleto para a linguagem abstrata, bem como o Makefile.

## O BNFC

Uma explicação aprofundada do BNFC pode ser encontrada no [repositório do projeto no GitHub](https://github.com/BNFC/bnfc). Para instalá-lo, eu recomendo o stack, que já adiciona o BNFC ao PATH. Execute o seguinte comando no terminal 

```
    stack install BNFC
    bnfc --help
```

Para gerar os arquivos fonte do lexer, do parser, o makefile e compilar esses arquivos fonte, execute o comando a seguir

```
    bnfc -d -m <nome>.cf && make
```

em que \<nome>.cf é onde está definida a linguagem abstrata.

Depois disso, é necessário definir o driver do interpretador no arquivo `Interpret.hs` e implementar a lógica da interpretação da linguagem objeto no arquivo `Interpreter.hs`. Finalmente, geramos o executável pelo comando a seguir

```
    ghc --make Interpret.hs
```

e podemos testar o interpretador chamando o executável seguido de um código ou arquivo na linguagem objeto.

```
    Interpret < <<código_ou_arquivo>>
```