#############################################################
# Dia 3 (29/04/2021) - Criando sua própria função

#  Operador | Descrição          
#  <        | menor que          
#  >        | maior que          
#  <=       | menor ou igual que 
#  >=       | maior ou igual que 
#  ==       | igual a            
#  !=       | diferente de       

#  !        | "NÃO" lógico               
#  &        | "E" lógico para elementos  
#  &&       | "E" lógico                 
#  |        | "OU" lógico para elementos 
#  ||       | "OU" lógico                  

x = c(1, 2, 9, 4, 5)
y = c(1, 2, 6, 7, 8)
x > y # retorna TRUE para os maiores e FALSE para os menores
x < y # retorna TRUE para os menores e FALSE para os maiores
x == y # retorna TRUE para os x que são iguais a y (na mesma posição)
x != y # retorna TRUE para os x que são diferentes de y
x >= y # retorna TRUE para os maiores ou iguais e FALSE para os menores
x <= y # retorna TRUE para os menores ou iguais e FALSE para os maiores

#-----------
# função which

## A função which funciona como se fosse uma pergunta: Quais?

a = c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20)
a > 10 # retorna um vetor contendo TRUE se for maior que 10 que FALSE se for menor

# retorna a posição no vetor dos valores de a que são maiores que 10. Como
# se perguntassemos, onde estão os valores maiores que 10 em a?
which(a > 10)

# retorna os valores de a que são maiores que 10 (é o valor, não é a posição
# como anteriormente)
a[which(a > 10)]

# quais foram os terremotos com profundidade maior que 670 km?
quakes[which(quakes$depth > 670), ]

# calculando qual o percentual de terremotos com profundidade maior que 670
# km dentre o total
nrow(quakes[which(quakes$depth > 670), ])/nrow(quakes) * 100

# quais foram os terremotos com profundidade maior que 650 km e com
# longitude menor ou igual a 180?
quakes[which(quakes$depth > 650 & quakes$long <= 180), ]

#-----------
# funções aggregate e by

# As funções aggregate e by podem ser utilizadas para aplicar
# uma função em todas as colunas de uma tabela
# As duas funções retornam os mesmos resultados, mas de formas diferentes.

# Calcular a média de comprimento por cada espécie de flor
aggregate(iris$Sepal.Length ~ iris$Species, FUN = mean)
by(iris$Sepal.Length, iris$Species, FUN = mean)

# Calcular as medidas estatísticas de comprimento por cada espécie de flor
aggregate(iris$Sepal.Length ~ iris$Species, FUN = summary)
by(iris$Sepal.Length, iris$Species, FUN = summary)

# Calcular a medidas estatísticas de todas as características por cada espécie de flor
aggregate(. ~ Species, data = iris, summary)
by(iris, iris$Species, summary)

#-----------
# if else

# Uma declaração if else em programação é uma instrução
# condicional que executa um conjunto diferente de declarações,
# dependendo se uma expressão é verdadeira ou falsa

x = 1
if (x == 1) {
  "VERDADE"
} else {
  "MENTIRA"
}

x = 3 # atribuindo valor 3 a x
if (x == 1) {
  "VERDADE"
} else {
  "MENTIRA"
}

ifelse(x == 1, "VERDADE", "MENTIRA")

#-----------
# for while

# Em programação, um loop é uma sequência de instruções que
# são continuamente repetidas até que uma determinada condição seja alcançada

aux = NULL
for (i in 1:5) {
  aux[i] = i + sqrt(i)
}
aux

a = 0
d = 0
while (a < 3) {
  a = a + 1
  d = d + 20
  print(d)
}

#-----------
# Criando funções

# Apesar do R ser muito útil para análise de dados, muitos
# usuários as vezes precisam crias suas próprias funções. 
# Esta é uma das maiores vantagens do R.

# Função é um comando que a partir dos dados de entrada
# (argumentos) te retorna uma saída

# Passo a passo
## (1) function() -> "estou criando uma função"
## (2) lista de argumentos -> apresenta os argumentos que serão avaliados pela sua função
## (3) corpo da função -> parte em que você escreve os cálculos que deseja
## (4) salvando a funcao -> dê um nome a ela

funcao.teste = function(a, b, c) {
  resultado = a + b + c^2
  return(resultado)
}
funcao.teste(2, 2, 3)

funcao.teste2 = function(x) {
  if (is.vector(x)) {
    val1 = sum(x)
    val2 = prod(x)
    cat("soma =", val1, "\n", "produtório =", val2, "\n")
  } else {
    print("A função só pode ser aplicada em um vetor")
  }
}
aux = matrix(seq(1:10), ncol = 5)
funcao.teste2(aux)

aux2 = c(1:10)
funcao.teste2(aux2)

calculo.min = function(x) {
  if (is.vector(x)) {
    min = x[1]
    for (i in 2:length(x)) {
      if (x[i] < min) {
        min = x[i]
      } else {
        min = min
      }
    }
    cat("Valor mínimo igual a", min, "\n")
  } else {
    print("A função só pode ser aplicada em um vetor")
  }
}
valores = c(-1000:150)
calculo.min(valores)