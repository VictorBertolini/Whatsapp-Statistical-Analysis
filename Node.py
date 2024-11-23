class Node():
    # With a valid whatsapp line, get the information of it and put it inside the node
    def getInformation(self, line):
        # Get Data
        self.day = line[0:2]
        self.month = line[3:5]
        self.year = line[6:10]

        # Get hour
        self.hour = line[11:13]

        # Get name
        try:
            colon_position = line.index(':', 19)
            if line.find("mudou o nome do grupo") == -1:
                self.name = line[19:colon_position]
            else:
                self.name = " "
        except ValueError:
            colon_position = 18 
            self.name = " "

        # Get Message
        self.message = line[colon_position + 1: len(line)]

        # Type of Message
        if self.message.find(".pdf") >= 0:
            self.messageType = "PDF"
        elif self.message.find(".jpg") >= 0:
            self.messageType = "Image"
        elif self.message.find(".webp") >= 0:
            self.messageType = "Sticker"
        elif self.message.find(".mp4") >= 0:
            self.messageType = "Video"
        else:
            self.messageType = "Message"

    # Print the information inside the node
    def show(self):
        print(f"{self.day}/{self.month}/{self.year} - {self.hour} - {self.name}: {self.message}\n")
            
