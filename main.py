from Functions import *

# Read all the .txt of the Whatsapp Conversation 
text = read_txt("Whatsapp text file name.txt")

node_list = treat_lines(text)

# With the NodeList the function save everything in a .xlsx file 
save_xlsx(node_list, excel_file_name="Whatsapp Data.xlsx")

# Key to know that the program fineshed 
print("Program fineshed")


