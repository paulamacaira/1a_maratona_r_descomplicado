#############################################################
# Dia 1 (27/04/2021) - Manipulação de dados com o {tidyverse}

# O tidyverse é uma coleção de pacotes R projetados para ciência de dados.
# Todos os pacotes compartilham uma filosofia de design, gramática e estruturas de dados subjacentes.

# Principais pacotes:

#### ggplot2:  para criar gráficos
#### dplyr: para manipulação de dados
#### tidyr: para organizar os dados
#### readr: para ler dados como csv, tsv e fwf
#### purrr: para trabalhar com funções e vetores
#### tibble: reformulação moderna do data.frame
#### stringr: para trabalhar com strings
#### forcats: para trabalhar com fatores

# Melhor referência (online e 100% gratuita): https://r4ds.had.co.nz/

# Instalando e carregando os pacotes necessários

install.packages("tidyverse")
library(tidyverse)

# Temos basicamente 2 maneiras de criar um tibble:

#### 1) transformando um data.frame em um tibble

iris
as_tibble(iris)

#### 2) a partir de vetores individuais

tibble(
  x=1:5,
  y=1,
  z=x^2+y
)

# ---------
# PRINCIPAIS FUNÇÕES:

#### filter(): escolhe casos com base em seus valores
#### arrange(): altera a ordem das linhas
#### select(): escolhe variáveis com base em seus nomes
#### mutate(): adiciona novas variáveis que são funções de variáveis existentes
#### summarise(): reduz vários valores a um único resumo
#### group_by(): agrupa classes

starwars #base de dados do pacote {dplyr} com informações dos personagens de Star Wars

starwars %>% View()

## filter(): Filtrando a base de dados starwars para personagens com mais de 160 cm de altura ou olhos azuis

starwars %>%
  filter(height > 160 |
           eye_color == "blue")

## arrange(): Ordenando a  base de dados starwars pelo peso e desempate por maior ano de nascimento

starwars %>%
  arrange(height, -mass)

## select(): Selecionando somente as variáveis name e hair_color da  base de dados starwars

starwars %>%
  select(name, hair_color)

## mutate(): Criando a variável "Pes" que é uma transformação da height de cm para pés

starwars %>%
  mutate(Pes = height*0.0328084)

## summarise(): Contando a quantidade de espécies distintas possui base de dados starwars

starwars %>%
  summarise(n_distinct(species))

## group_by(): Agrupando as linhas por gender e calculando a média da variável height

starwars %>% 
  group_by(gender) %>%
  summarise(Media = mean(height))

# ---------
# CONCATENANDO OBJETOS

band_members
band_instruments

#### inner_join(): retorna todas as linhas de x onde há valores correspondentes em y, e todas as colunas de x e y.
# Se houver várias correspondências entre x e y, todas as combinações das correspondências serão retornadas.

band_members %>% 
  inner_join(band_instruments)

#### left_join(): retorna todas as linhas de x e todas as colunas de x e y. 
# As linhas em x sem correspondência em y terão valores NA nas novas colunas. 
# Se houver várias correspondências entre x e y, todas as combinações das correspondências serão retornadas.

band_members %>% 
  left_join(band_instruments)

#### right_join(): retorna todas as linhas de y e todas as colunas de x e y. 
# As linhas em y sem correspondência em x terão valores NA nas novas colunas.
# Se houver várias correspondências entre x e y, todas as combinações das correspondências serão retornadas.

band_members %>% 
  right_join(band_instruments)

#### full_join(): retorna todas as linhas e todas as colunas de x e y. 
# Onde não houver valores correspondentes, retorna NA para o que está faltando

band_members %>% 
  full_join(band_instruments)