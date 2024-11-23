library(readxl)
library(ggplot2)
library(gridExtra)
Author <- "Victor Bertolini de Sousa"


path <- # Path to the .xlsx file

whatsapp <- read_xlsx(path, sheet="Data")

# ============================================================
# Cleaning and treating the data
whatsapp$Year <- as.factor(whatsapp$Year)
whatsapp$Name <- as.factor(whatsapp$Name)
whatsapp$Month <- as.factor(whatsapp$Month)
whatsapp$Hour <- as.factor(whatsapp$Hour)
whatsapp <- na.omit(whatsapp)
whatsapp <- whatsapp[whatsapp$Name != "Erro",]
whatsapp <- whatsapp[whatsapp$Name != "Meta AI",]


# ============================================================
# Graphic by Year 
ggplot(whatsapp, aes(x = Year, fill = Year)) + 
    geom_bar() + 
    scale_fill_brewer(palette = "Blues") +
    theme_minimal(base_size = 18) + 
    labs(
        title = "Messages Per Year", 
        x = "Year", 
        y = "Count"
    )

# Graphic of the Messages per person
ggplot(whatsapp, aes(x = Name, fill = Name)) +
    geom_bar() +
    theme_minimal(base_size = 18) + 
    labs(
        title = "Messages Per Person", 
        x = "Name", 
        y = "Count"
    )

# Graphic of Messages per Month
ggplot(whatsapp, aes(x = Month, fill = Month)) +
    geom_bar() +
    theme_minimal(base_size = 18) +
    labs(
        title = "Messages Per Month", 
        x = "Month", 
        y = "Count"
    )

# Graphic of Messages per Month per Person
ggplot(whatsapp, aes(x = Month, fill = Name)) +
    geom_bar() +
    theme_minimal(base_size = 18) +
    labs(
        title = "Messages Per Month Per Person", 
        x = "Month", 
        y = "Count"
    )

# Graphic of Messages per Hour 
ggplot(whatsapp, aes(x = Hour, fill = Hour)) +
    geom_bar() +
    theme_minimal(base_size = 18) +
    labs(
        title = "Messages Per Hour", 
        x = "Hour", 
        y = "Count"
    )

# Graphic of Messages per Hour Per Person
ggplot(whatsapp, aes(x = Hour, fill = Name)) +
    geom_bar() +
    theme_minimal(base_size = 18) +
    labs(
        title = "Messages Per Hour Per Person", 
        x = "Hour", 
        y = "Count"
    )

# ============================================================
# Stickers Sent Per Person
sticker <- whatsapp[whatsapp$Type == "Sticker",]

ggplot(sticker, aes(x = Name, fill = Name)) +
    geom_bar() +
    theme_minimal(base_size = 18) +
    labs(
        title = "Stickers Sent Per Person", 
        x = "Name", 
        y = "Count"
    )

# Images Sent Per Person
image <- whatsapp[whatsapp$Type == "Image",]

ggplot(image, aes(x = Name, fill = Name)) +
    geom_bar() +
    theme_minimal(base_size = 18) +
    labs(
        title = "Images Sent Per Person", 
        x = "Name", 
        y = "Count"
    )


# Videos Sent Per Person
video <- whatsapp[whatsapp$Type == "Video",]

ggplot(video, aes(x = Name, fill = Name)) +
    geom_bar() +
    theme_minimal(base_size = 18) +
    labs(
        title = "Videos Sent Per Person", 
        x = "Name", 
        y = "Count"
    )

# ============================================================
# COMPARE
# Write 2 years to compare both Per Month
year1 <- 2023
year2 <- 2024
whatsapp1 <- whatsapp[whatsapp$Year == year1,]
whatsapp2 <- whatsapp[whatsapp$Year == year2,]

title1 <- paste("Messages Per Month", as.character(year1))
title2 <- paste("Messages Per Month", as.character(year2))

msg_y1 <- 
    ggplot(whatsapp1, aes(x = Month, fill = Month)) +
        geom_bar() +
        theme_minimal(base_size = 18) +
        labs(
            title = title1, 
            x = "Month", 
            y = "Count"
        )

msg_y2 <- 
    ggplot(whatsapp2, aes(x = Month, fill = Month)) +
    geom_bar() +
    theme_minimal(base_size = 18) +
    labs(
        title = title2, 
        x = "Month", 
        y = "Count"
    )

grid.arrange(msg_y1, msg_y2)


# COMPARE
# Write 2 years to compare both Per Hour
year1 <- 2023
year2 <- 2024
whatsapp1 <- whatsapp[whatsapp$Year == year1,]
whatsapp2 <- whatsapp[whatsapp$Year == year2,]

title1 <- paste("Messages Per Hour", as.character(year1))
title2 <- paste("Messages Per Hour", as.character(year2))

msg_y1 <- 
    ggplot(whatsapp1, aes(x = Hour, fill = Hour)) +
    geom_bar() +
    theme_minimal(base_size = 18) +
    labs(
        title = title1, 
        x = "Hour", 
        y = "Count"
    )

msg_y2 <- 
    ggplot(whatsapp2, aes(x = Hour, fill = Hour)) +
    geom_bar() +
    theme_minimal(base_size = 18) +
    labs(
        title = title2, 
        x = "Hour", 
        y = "Count"
    )

grid.arrange(msg_y1, msg_y2)

# ============================================================

# Top 10 most sent messages 
top_messages <- as.factor(whatsapp$Message)
top_messages <- summary(top_messages)


for (i in 1:10) {
    word <- names(top_messages)[i]
    frequencie <- top_messages[i]
    print(paste(frequencie, "times:", word))
}


# Top 10 most sent stickers
top_stickers <- grep(".webp", whatsapp$Message, value = TRUE)
top_stickers_freq <- table(top_stickers)
top_stickers_freq <- sort(top_stickers_freq, decreasing = TRUE)

print("Top 10 most sent stickers:")
for (i in 1:min(10, length(top_stickers_freq))) {  
    stick <- names(top_stickers_freq)[i]
    frequencie <- top_stickers_freq[i]
    
    print(paste(frequencie, "times:", stick))
}
