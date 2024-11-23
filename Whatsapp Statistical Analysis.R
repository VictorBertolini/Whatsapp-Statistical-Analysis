library(readxl)
library(ggplot2)
library(gridExtra)

path <- # Path to the .xlsx file

whatsapp <- read_xlsx(path, sheet="whatsapp")


# Cleaning and treating the data
whatsapp$Year <- as.factor(whatsapp$Year)
whatsapp$Name <- as.factor(whatsapp$Name)
whatsapp$Month <- as.factor(whatsapp$Month)
whatsapp$Hour <- as.factor(whatsapp$Hour)
whatsapp <- na.omit(whatsapp)
whatsapp <- whatsapp[whatsapp$Name != "Erro",]
whatsapp <- whatsapp[whatsapp$Name != "Meta AI",]



# Graphic by Year 
ggplot(winx, aes(x = Year, fill = Year)) + 
    geom_bar() + 
    scale_fill_brewer(palette = "Blues") +
    theme_minimal(base_size = 18) + 
    labs(
        title = "Número de Mensagens por ano", 
        x = "Ano", 
        y = "Contagem"
    )

# Graphic of the Messages per person
ggplot(winx, aes(x = Name, fill = Name)) +
    geom_bar() +
    theme_minimal(base_size = 18) + 
    labs(
        title = "Messages Per Person", 
        x = "Name", 
        y = "Count"
    )

# Graphic of Messages per Month
ggplot(winx, aes(x = Month, fill = Month)) +
    geom_bar() +
    theme_minimal(base_size = 18) +
    labs(
        title = "Messages Per Month", 
        x = "Month", 
        y = "Count"
    )

# Graphic of Messages per Month per Person
ggplot(winx, aes(x = Month, fill = Name)) +
    geom_bar() +
    theme_minimal(base_size = 18) +
    labs(
        title = "Messages Per Month Per Person", 
        x = "Month", 
        y = "Count"
    )

# Graphic of Messages per Hour of the Day
ggplot(winx, aes(x = Hour, fill = Hour)) +
    geom_bar() +
    theme_minimal(base_size = 18) +
    labs(
        title = "Messages Per Hour", 
        x = "Hour", 
        y = "Count"
    )

# Graphic of Messages per Hour Per Person
ggplot(winx, aes(x = Hour, fill = Name)) +
    geom_bar() +
    theme_minimal(base_size = 18) +
    labs(
        title = "Messages Per Hour Per Person", 
        x = "Hour", 
        y = "Count"
    )

# Graphic of Messages 
ggplot(winx, aes(x = Hour, fill = Hour)) +
    geom_bar() +
    theme_minimal() +
    labs(
        title = "Número de Mensagens por Hora do Dia", 
        x = "Horário", 
        y = "Quantidade"
    )







