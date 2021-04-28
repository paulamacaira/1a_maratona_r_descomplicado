#############################################################
# Dia 2 (28/04/2021) - Gráficos com o {ggplot2}

# ggplot2 é um sistema para criar gráficos de forma declarativa e baseada na Gramática dos Gráficos.
# Você fornece os dados, diz ao ggplot2 como mapear as variáveis para a estética, quais gráficos primitivos usar e ele cuida dos detalhes.

# Instalando e carregando os pacotes necessários
## Pode usar o tidyverse - como fizemos ontem
install.packages("tidyverse")
library(tidyverse)

## Ou pode usar diretamente o ggplot2
install.packages("ggplot2")
library(ggplot2)

# Passos resumidos
## (1) forneça uma base de dados e mapeie as estéticas com a função aes()
## (2) adicione camadas: geom_point(), geom_histogram() etc.
## (3) customize: color, size, shape etc.
## (4) especifique facetas: facet_wrap(), facet_grid() etc.

# OBSERVAÇÃO: ggplot funciona apenas com data.frames

midwest
midwest %>% View()

#-----------
## passo (1)
#-----------

ggplot(midwest, aes(x=area, y=poptotal))

midwest %>% 
  ggplot(aes(x = area, y = poptotal))

#-----------
## passo (2)
#-----------

#### duas variáveis, x contínuo e y contínuo

ggplot(midwest, aes(x=area, y=poptotal)) +
  geom_point()

ggplot(midwest, aes(x=area, y=poptotal)) +
  geom_smooth()

ggplot(midwest, aes(x=area, y=poptotal, label=state)) +
  geom_label()

ggplot(midwest, aes(x=area, y=poptotal, label=state)) +
  geom_text()

#### duas variáveis, x discreto e y contínuo

ggplot(midwest, aes(x=state,y=area)) +
  geom_col()

ggplot(midwest, aes(x=state,y=area)) +
  geom_boxplot()

ggplot(midwest, aes(x=state,y=area)) +
  geom_violin()

#### duas variáveis, x discreto e y discreto

ggplot(midwest, aes(x=state,y=category)) +
  geom_count()

#### uma variável contínua

ggplot(midwest, aes(area)) +
  geom_density()

ggplot(midwest, aes(area)) +
  geom_histogram()

#### visualizando erros

df = data.frame(grp = LETTERS[1:5], fit = 8:4, se = 1:5)

ggplot(df, aes(grp, ymin = fit-se, ymax = fit+se)) +
  geom_errorbar()

#-----------
## extra: combine camadas!
#-----------

ggplot(midwest, aes(x=area, y=poptotal)) +
  geom_point(aes(col=state)) +
  geom_smooth(method="lm")

ggplot(midwest, aes(x=state,y=area)) +
  geom_boxplot() +
  geom_violin()

ggplot(midwest, aes(x=state,y=area)) +
  geom_boxplot() +
  geom_violin(alpha=0.4)

midwest %>% 
  group_by(state) %>% 
  summarise(media = mean(area), 
            desvio = sd(area)) %>%
  ggplot(aes(x=state,y=media)) +
  geom_col() +
  geom_errorbar(aes(ymin=media-desvio, ymax=media+desvio), 
                width=.2)

#-----------
## passo (3)
#-----------

ggplot(midwest, aes(x=area,y=poptotal)) +
  geom_point(col="steelblue")

ggplot(midwest, aes(x=area,y=poptotal)) +
  geom_point(col="steelblue", size=6)

ggplot(midwest, aes(x=area,y=poptotal)) +
  geom_point(col="steelblue", size=6, shape=10)

ggplot(midwest, aes(x=area,y=poptotal)) +
  geom_point(aes(col=state))

ggplot(midwest, aes(x=area,y=poptotal)) +
  geom_point(aes(size=state))

ggplot(midwest, aes(x=area,y=poptotal)) +
  geom_point(aes(shape=state))

ggplot(midwest, aes(x=area, y=poptotal)) +
  geom_smooth(aes(col=state))

midwest %>% 
  group_by(state) %>% 
  summarise(media = mean(area), 
            desvio = sd(area)) %>%
  ggplot(aes(x=state,y=media)) +
  geom_col(aes(fill=state)) +
  geom_errorbar(aes(ymin=media-desvio, ymax=media+desvio), 
                width=.2)

#### temas

ggplot(midwest, aes(x=area,y=poptotal)) +
  geom_point(aes(col=state)) +
  theme_classic()

ggplot(midwest, aes(x=area,y=poptotal)) +
  geom_point(aes(col=state)) +
  theme_bw()

ggplot(midwest, aes(x=area,y=poptotal)) +
  geom_point(aes(col=state)) +
  theme_dark()

#### ordenação

ggplot(midwest, aes(x=reorder(county,area),y=area)) +
  geom_col()

ggplot(midwest, aes(x=reorder(state,-area),y=area)) +
  geom_boxplot()

midwest %>% 
  group_by(state) %>% 
  summarise(media = mean(area), 
            desvio = sd(area)) %>%
  ggplot(aes(x=reorder(state,media),y=media)) +
  geom_col(aes(fill=state)) +
  geom_errorbar(aes(ymin=media-desvio, ymax=media+desvio), 
                width=.2)

#### títulos, legendas etc.

ggplot(midwest, aes(x=area, y=poptotal)) +
  geom_point(aes(col=state))

ggplot(midwest, aes(x=area, y=poptotal)) +
  geom_point(aes(col=state)) +
  labs(title="Área vs População",
       subtitle = "Este é o subtítulo",
       y="População",
       x="Área",
       caption = "Este é o Caption") +
  theme(legend.position = "left") +
  scale_color_discrete(name = "Nova Legenda") # atenção! depende de como ajustou a legenda

?theme

ggplot(midwest, aes(x=area, y=poptotal)) +
  geom_point(aes(col=state)) +
  labs(title="Área vs População",
       subtitle = "Este é o subtítulo",
       y="População",
       x="Área",
       caption = "Este é o Caption") +
  theme(legend.position = "left",
        axis.title = element_blank()) +
  scale_color_discrete(name = "Nova Legenda") # atenção! depende de como ajustou a legenda

#-----------
## passo (4)
#-----------

# Quando temos uma única observação para repartir, usamos facet_wrap

ggplot(midwest, aes(x=area, y=poptotal)) +
  geom_point(aes(col=state)) +
  labs(title="Área vs População", y="População", x="Área") +
  facet_wrap(~state)

ggplot(midwest, aes(x=area, y=poptotal)) +
  geom_point(aes(col=state)) +
  labs(title="Área vs População", y="População", x="Área") +
  facet_wrap(~state, nrow = 1)

# Agora quando usamos duas variáveis, usamos facet_grid

ggplot(midwest, aes(x=area, y=poptotal)) +
  geom_point(aes(col=state)) +
  labs(title="Área vs População", y="População", x="Área") +
  facet_grid(category~state)
