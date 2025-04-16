# Números com Sinal

Em Verilog existe a opção de tratar os números como com sinal `signed` ou então sem sinal `unsigned`. É importante entender esse tipo de comportamento para poder interpretar as expressões aritméticas corretamente ou então para escolher um certo comportamento para as operações

## Tipos de operação que podem ser feitos

Quando se faz a operação com os bits, a saída pode ser com sinal ou sem sinal. Isso depende de quais foram os operandos. Por padrão os valores são declarados são `unsigned`. Para se declarar um valor com sinal é necessário usar a diretiva `signed` Veja no trecho abaixo:

```Verilog
wire signed [3:0] m
```

Existem regras para operar números com e sem sinal. Existe o caso trivial em que dois números de tipos iguais terão saídas do mesmo tipo, mas existe uma regra geral, escrita a seguir.

> Se todos os sinais de uma operação são `signed`, o resultado é `signed`. Caso contrário, os operandos e o resultados são tratados como `unsigned`.

## Comportamento potencialmente indesejado

O comportamento descrito na regra anterior pode levar a resultados inesperados. Veja no código abaixo um exemplo em que as saídas das operações mudam radicalmente dependendo se a entrada é com ou sem sinal.

```verilog
module tb();

    wire [7:0] x, y;
    reg signed [7:0] s;
    reg [7:0] u;
    reg signed [3:0] m;

    assign x = s + m;  // signed + signed
    assign y = u + m;  // unsigned + signed

    initial begin
        s = 8'b0000_0111;  // decimal 7
        u = 8'b0000_0111;  // decimal 7

        m = -4;  // decimal -4
        $display("m: %b  %d", m, m);
        $display("x: %b  %d", x, x);
        $display("y: %b  %d  **SURPRESA**", y, y);
    end
endmodule
```
A saída desse código aparece abaixo:

```terminal
m:     1100    -4
x: 00000011     3
y: 00010011    19  **SURPRESA**
```

> Copie e cole esse código para experimentar novos valores.

Essa diferença nos resultados `x` e `y` ocorre porque o valor de `m` é estendido para `m_ex` de maneiras distintas dependendo da operação.

> Quando é feita uma operação com dois sinais de largura diferente, o menor deles é estendido.

Quando a operação envolve dois números `signed`, como é o caso de `x`, o sinal `m` é estendido para `m_ex` como número negativo (-4).

Quando a operação envolve um número `signed` e outro `unsigned`, como é o caso de `y`, sinal `m` é estendido para `m_ex` como número positivo (12).

```Verilog
x (signed + signed): m = 1100 (-4) -> m_ex = 11111100 (-4)

y (unsigned + signed): m = 1100 (-4) -> m_ex = 00001100 (12)
```

## Módulo a ser desenvolvido

Nesta atividade você deverá fazer um módulo que recebe quatro entradas, cada uma marcada como sendo com ou sem sinal e a saída de ser a operação se soma entre os dois números selecionados. A operação a ser feita é selecionada por um código que também é entrada. As entradas são as seguintes:
- entrada_signed_1
- entrada_signed_2
- entrada_unsigned_1
- entrada_unsigned_2
- código

A tabela abaixo mostra o comportamento desejado para as operações.

Código | Operação |
|------|----------|
00     | signed_1 + signed_2     |
01     | unsigned_1 + unsigned_2 |
10     | unsigned_1 + signed_1   |
11     | unsigned_1 + signed_2   |

## Execução da atividade

Siga o modelo de módulo já fornecido e utilize o testbench e scripts de execução para sua verificação.

Uma vez que estiver satisfeito com o circuito, execute o script de testes com `./run-all.sh`. Serão feitos 10 testes: cada um deles mostrará na tela `ERRO` em caso de falha ou `OK` em caso de sucesso.

## Entrega

Para entregar o projeto, basta fazer um *commit* no repositório do GitHub. O GitHub Classroom já está configurado para verificar a entrega e atribuir a nota dos testes automaticamente.

> Os testes do GitHub estão embutidos nos arquivos do laboratório. Se quiser saber mais sobre eles, veja o script de correção 'run.sh' do repositório do GitHub. Não altere os arquivos de correção!