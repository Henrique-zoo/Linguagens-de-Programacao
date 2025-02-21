# **Linguagens de Programação**

## **Sumário**
1. [Do Repositório](#do-repositório)
2. [Da Matéria](#da-matéria)
3. [Tipos Algébricos](#tipos-algébricos)
    1. [Álgrebra de Tipos](#álgebra-de-tipos)
        1. [Soma](#soma--união-disjunta)
        2. [Produto](#produto--produto-cartesiano)
        3. [Exponeciação](#exponenciação--conjunto-de-funções)
    2. [Aplicação no Haskell](#aplicação-no-haskell)
        1. [Tipo Produto](#tipos-produto-product-types)
        2. [Tipo Soma](#tipos-soma-sum-types)
        3. [Tipos Soma Especiais](#tipos-soma-especiais-do-haskell-maybe-e-either)
4. [Tipos Função](#tipos-função)

## **Do Repositório**
Nesse repositório, estão os códigos desenvolvidos na matéria Linguagens de Programação (CIC0093), ministrada pelo prof. Vander Ramos Alves no semestre 2024.2, além de uma explanação teórica sobre a matéria da disciplina.

O repositório é organizado da seguinte forma:
```plaintext
LINGUAGENS-DE-PROGRAMACAO
├─── Interpretadores
├─── Lista de Exercícios
├─── Trabalho_1
│     └─── códigos das questões do trabalho 1
└─── Trabalho_2
      └─── códigos das questões do trabalho 2
```

## **Da Matéria**
Nessa matéria, buscamos compreender as várias características de diferentes linguagens de programação. Em especial, nos aprofundamos nos variados paradigmas e suas peculiaridades. Para isso, desenvolvemos vários interpretadores para linguagens de cada paradigma de interesse:

- Linguagem de Expressões
- Linguagem Imperativa 1 (sem funções)
- Linguagem Imperativa 2 (com funções)

    - Sem tipagem
    - Com tipagem
- Linguagem Orientada a Objetos

    - Básica
    - Com herança, polimorfismo, etc.

Os interpretadores são desenvolvidos na linguagem funcional Haskell, de forma que a primeira parte do curso se dedica a ensiná-la, como pode ser verificado no `Trabalho_1`. O `Trabalho_2` consiste em realizar alterações no interpretador da Linguagem Imperativa 1 para melhorar a linguagem.

## **Tipos Algébricos**

Tipos algébricos são uma construção fundamental em linguagens de programação funcional. Eles permitem a definição de tipos de dados complexos a partir da combinação de outros tipos. Para entender como essas combinações são feitas, é necessária uma introdução teórica à **álgebra de tipos**, que é a base teórica e a origem do nome "Tipos Algébricos".

### **Álgebra de Tipos**

A álgebra de tipos é um sistema que trata tipos de dados como entidades matemáticas, permitindo a combinação de tipos por meio de operações. Essas operações são análogas às operações da **teoria dos conjuntos**, o que permite uma abordagem formal e matemática para o estudo de tipos. Definimos, portanto, **tipos como o conjunto de seus possíveis valores**.

Para os exemplos, consideramos
    <div align='center'>
        A = \{1, 2\} (cardinalidade |A| = 2)
    </div>

e 
    <div align='center'>
        B = \{‘a', ‘b', ‘c'\} (cardinalidade |B| = 3)
    </div>

#### **Soma ⇋ União Disjunta $( A \sqcup B )$**
Representa uma escolha entre tipos. A soma de dos tipos $A$ e $B$ na álgebra de tipos corresponde à união disjunta desses conjuntos na teoria de conjuntos.

- Utiliza-se união disjunta e não união simples, pois a união disjunta de dois conjuntos $A$ e $B$, denotada por $A ⊔ B$, é uma operação que preserva a "origem" dos elementos, mesmo que eles sejam iguais. Em outras palavras, os elementos da união disjunta são "marcados" para indicar de qual conjunto original eles vieram, dessa forma, evitando confusão entre dois valores iguais de tipos diferentes.

- Definição Formal: Sejam $A$ e $B$ tipos quaisquer e $C = A ⊔ B$, temos
      <div align='center'>
          $C = \{(a,0) | a ∈ A\} ∪ \{(b,1) | b ∈ B\}$
      </div>

- Exemplo: Para os conjuntos $A$ e $B$ definidos na introdução, temos:
    
    <div align='center'>
        $A ⊔ B = \{(1,0), (2,0), (‘a´,1), (‘b´,1), (‘c´,1)\}$
    </div>
    <div align='center'>
        $(cardinalidade |A ⊔ B| = |A| + |B| = 5)$
    </div>

#### **Produto ⇋ Produto Cartesiano ($A \times B$)**
Representa uma combinação de tipos. O produto de dois tipos na álgebra de tipos corresponde ao produto cartesiano entre seus conjuntos.

- Definição Formal: Sejam $A$ e $B$ tipos quaisquer e $C = A × B$, temos
    <div align='center'>
        $C = \{(a,b) | a ∈ A, b ∈ B\}$
    </div>
    

- Exemplo: Para os conjuntos $A$ e $B$ definidos na introdução, temos:
    <div align='center'>
        A × B = {(1, 'a'), (1, 'b'), (1, 'c'), (2, 'a'), (2, 'b'), (2, 'c')}
    </div>
    <div align='center'>
        (cardinalidade |A × B| = |A| × |B| = 6)
    </div>

#### **Exponenciação ⇋ Conjunto de funções ($B^A$)**
Representa todas as funções possíveis de $A$ para $B$. A exponeciação dos tipos $A$ e $B$ corresponde ao conjunto de funções do conjunto $A$ para o conjunto $B$, isto é, é conjunto de todas as funções possíveis que mapeiam elementos de $A$ para elementos de $B$.

- Definição Formal: Sejam $A$ e $B$ tipos quaisquer e $C = A ^ B$, temos
    <div align='center'>
        C = {f | f : A → B}
    </div>

    em que cada $f$ pode ser visto como um conjunto de pares ordenados

    <div align='center'>
        f = {(a, b) | ∀ a ∈ A, ∃! b ∈ B}
    </div>
    - Note que $f_i ⊆ A × B ∀ i$.

- Exemplo: Para os conjuntos $A$ e $B$ definidos na introdução, temos:
    <div align='center'>
        $f_1: \ f_1(1) = ´a´, \ f_1(2) = ´a´ \Rightarrow f_1 = \{(1, ´a´), (2,´a´)\}$
    </div>
    <div align='center'>
        $f_2: \ f_2(1) = ´a´, \ f_2(2) = ´b´ \Rightarrow f_2 = \{(1, ´a´), (2,´b´)\}$
    </div>
    <div align='center'>    
        $f_3: \ f_3(1) = ´a´, \ f_3(2) = ´c´ \Rightarrow f_3 = \{(1, ´a´), (2,´c´)\}$
    </div>
    <div align='center'> 
        $f_4: \ f_4(1) = ´b´, \ f_4(2) = ´a´ \Rightarrow f_4 = \{(1, ´b´), (2,´a´)\}$
    </div>
    <div align='center'> 
        $f_5: \ f_5(1) = ´b´, \ f_5(2) = ´b´ \Rightarrow f_5 = \{(1, ´b´), (2,´b´)\}$
    </div>
    <div align='center'> 
        $f_6: \ f_6(1) = ´b´, \ f_6(2) = ´c´ \Rightarrow f_6 = \{(1, ´b´), (2,´c´)\}$
    </div>
    <div align='center'> 
        $f_7: \ f_7(1) = ´c´, \ f_7(2) = ´a´ \Rightarrow f_7 = \{(1, ´c´), (2,´a´)\}$
    </div>
    <div align='center'> 
        $f_8: \ f_8(1) = ´c´, \ f_8(2) = ´b´ \Rightarrow f_8 = \{(1, ´c´), (2,´b´)\}$
    </div>
    <div align='center'> 
        $f_9: \ f_9(1) = ´c´, \ f_9(2) = ´c´ \Rightarrow f_9 = \{(1, ´c´), (2,´c´)\}$
    </div>
    <div align='center'> 
        $B^A = \{f_1, \ f_2, \ f_3, \ f_4, \ f_5, \ f_6, \ f_7, \ f_8, \ f_9\}$
    </div>
    <div align='center'> 
        $(cardinalidade |B^A| = |B| ^{|A|} = 9)$
    </div>
### **Aplicação no Haskell**
Com o arcabouço teórico apresentado, podemos, finalmente entender os tipos algébricos no Haskell. Um tipo algébrico é um tipo de dados composto que pode ser definido como:

#### **Tipos Produto (Product Types)**
É um tipo formado pela combinação vários tipos em uma única estrutura. Em Haskell, define-se um tipo produto da seguinte forma:

```haskell
data <nome_do_tipo> = <construtor_do_tipo> <tipos_1> <tipo_2> ... <tipo_n>
``` 

- Exemplo:
```haskell
type Base = Double -- apenas para facilitar a leitura
type Altura = Double
data Retangulo = Retangulo Base Altura
```

Definições similares são comuns em várias linguagens. Em C/C++ e em Rust, por exemplo, a definição de uma `struct` é bastante similar:

```c
struct Retangulo {
    double base, altura;
};
```

```rust
struct Retangulo {
    base: f64,
    altura: f64,
}
```

A cardinalidade do tipo `Retangulo` é dada pela multiplicação da cardinalidade dos tipos `Base` e `Altura` (que são sinônimos de Double), desconsiderando o fato de que estamos lidando com sistemas digitais, consideramos $Double := {\displaystyle \mathbb {R} }$, fazemos
    <div align='center'> 
        |*Retangulo*| = |*Base*| × |*Altura*| = ℵ₁ × ℵ₁ = ℵ₁² = ℵ₁
    </div>

em que ℵ₁ é a cardinalidade dos reais.

#### **Tipos Soma (Sum Types)**
É um tipo que pode assumir um dos vários tipos que o compõe. Em Haskell, define-se um tipo soma da seguinte forma:

```haskell
data <nome_do_tipo> = <construtor_do_tipo_1> [<tipos_do_tipo_1>] | <construtor_do_tipo_2> [<tipos_do_tipo_2>] | ... | <construtor_do_tipo_n> [<tipos_do_tipo_n>]
``` 

- Exemplo:
```haskell
data Forma = Circulo Raio | Retangulo Base Altura -- Note que Retangulo é um tipo produto
```

O tipo soma não é tão comum em linguagens tradicionais (imperativas ou orientada a objetos) quanto o tipo produto, mas podemos fazer uma analogia entre um tipo soma e o conceito de herança da POO. Na herança, um objeto de uma classe pai abstrata (análoga ao tipo soma) pode ser uma instância de uma classe filho OU de outra.

O tipo soma também existe em outras linguagens funcionais e em linguagens mais modernas, como o Rust:

```rust
enum Forma {
    Circulo(f64),          // Variante com um valor (raio)
    Retangulo(f64, f64),   // Variante com dois valores (base e altura)
}
```

A cardinalidade do tipo `Forma` é dada pela soma da cardinalidade dos tipos `Circulo` e `Retangulo`
    <div align="center">
        |*Forma*| = |*Circulo*| + |*Retangulo*| = |*Raio*| + |*Base*| × |*Altura*| = ℵ₁ + ℵ₁ × ℵ₁ = ℵ₁
    </div>

em que ℵ₁ é a cardinalidade dos reais.

#### **Tipos Soma Especiais do Haskell: `Maybe` e `Either`**

1. **Tipo Maybe**: o tipo `Maybe` é um tipo soma que representa a possibilidade de um valor estar presente ou ausente. É amplamente utilizado para lidar com valores opcionais ou nulos de forma segura.
    ```haskell
    data Maybe a = Nothing | Just a
    ```
    - `Nothing`: Representa a ausência de valor.
    - `Just a`: Representa a presença de um valor do tipo a.
    - Exemplo:
        ```haskell
        div :: Double -> Double -> Maybe Double
        div _ 0 = Nothing -- divisão por 0 retorna nada
        div x y = Just (x / y) 
        ```

2. **Tipo Either**: o tipo `Either` é um tipo soma que representa uma escolha entre dois tipos. É frequentemente usado para lidar com resultados que podem ser de dois tipos diferentes, como sucesso ou erro.
    ```haskell
    data Either a b = Left a | Right b
    ```
    - `Left a`: Representa um valor do tipo a (geralmente usado para erros ou casos excepcionais).
    - `Right b`: Representa um valor do tipo b (geralmente usado para resultados bem-sucedidos).
    - Esse tipo é extensivamente utilizado no `Trabalho_2`.

## **Tipos Função**
Os tipos função são nada mais do que funções, porém, tendo em vista a álgebra de tipos, é interessante vê-los como tipos que representam mapeamentos ou transformações entre dois tipos: um tipo de entrada (A) e um tipo de saída (B) - note que A e B podem ser iguais. Os tipos função são denotados por A → B, onde A é o tipo de domínio (entrada) e B é o tipo de contradomínio (saída).
