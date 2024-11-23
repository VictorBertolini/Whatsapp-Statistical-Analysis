from Node import *
import openpyxl

"""
:read_txt: Read a .txt file of a exported converation in Whatsapp and return the lines
:@param txt_file_name: A .txt file name
:return: A list that contaion each line of the conversation
"""
def read_txt(txt_file_name):
    with open(txt_file_name, mode="r", encoding="utf-8") as file:
        return file.readlines()


"""
:save_xlsx: Save the information of a list of nodes in a .xlsx file 
:@param node_list: A list of nodes that containing information
:@param excel_file_name: The name of the excel file (that will be created)
:@param sheet_name: The name of the sheet that will contain the information
"""
def save_xlsx(node_list, excel_file_name = "Whatsapp Data.xlsx", sheet_name = "Data"):

    wb = openpyxl.Workbook()
    wb.create_sheet(sheet_name, 0)
    
    page = wb[sheet_name]

    page.append(["Day", "Month", "Year", "Hour", "Name", "Message", "Type"])

    for node in node_list:
        page.append([f"{node.day}", f"{node.month}", f"{node.year}", f"{node.hour}", f"{node.name}", f"{node.message}", f"{node.messageType}"])

    del wb["Sheet"]
    wb.save(excel_file_name)

"""
:text_to_nodes: Convert a list of lines in a list of nodes
:@param lines: A list of lines (correct ones) 
:return: A list of nodes with the information of the lines
"""
def text_to_nodes(lines):
    node_list = []
    for i in lines:
        node = Node()
        node.getInformation(i)
        node_list.append(node)
    return node_list

"""
:text_to_book: Get the list of lines (incorrect) and transform in a single text block (book)
:@param text: A list of lines of the conversation in Whatsapp
:return: A single text block with all the lines 
"""
def text_to_book(text):
    sep = ""
    book = sep.join(text)
    book = book.replace('\n', ' ')
    return book
"""
:find_hyphens: Get all the position of the hyphens and return it
:param book: A single block of text containing all the whatsapp conversation
:return: A list of all the positions of the hyphens in the book 
"""
def find_hyphens(book):
    positions = []
    for i, character in enumerate(book):
        if character == '-':
            positions.append(i)
    return positions

"""
:remove_files: Function to remove all lines that has "(arquivo anexado)" on it 
:param text: A list of lines  
:return: The list of lines without the ones with "(arquivo anexado)"
"""
def remove_files(text):
    i = len(text) - 1
    while i >= 0:
        
        line = text[i]
        if line.find("(arquivo anexado)") >= 0:
            text.pop(i)
        i = i -1

    return text

"""
:validate_hyphen_pos: See if all hyphens found are the ones that i want to work on it (put out the hyphen inside texts)
:@param book: A single text of the conversation
:@param hyphen_pos: A list with all the hyphen positions in the book
:return: A list with the valid positions of the book
"""
def validate_hyphen_pos(book, hyphen_pos):
    valid_pos = []

    for hyphen in hyphen_pos:
        if book[hyphen - 4] == ':' and book[hyphen - 12] == '/' and book[hyphen - 15] == '/':
            valid_pos.append(hyphen)
    return valid_pos


"""
:construct_lines: With a single text (book) transform in the correct lines like whatsapp
:@param book: A single text block 
:return: A list of lines like Whatsapp
"""
def construct_lines(book):
    hyphen_pos = find_hyphens(book)
    hyphen_pos = validate_hyphen_pos(book, hyphen_pos)
    lines = []

    # For each valid hyphen, get the line 
    for i in range(len(hyphen_pos) - 2):
        line = book[hyphen_pos[i] - 17:hyphen_pos[i + 1] - 17]
        lines.append(line)


    # Do the same thing, but now with the last message
    j = len(hyphen_pos) - 1
    while True:
        if book[hyphen_pos[j] - 4] == ':' and book[hyphen_pos[j] - 12] == '/' and book[hyphen_pos[j] - 15] == '/':
            line = book[hyphen_pos[j] - 17:len(book)]
            lines.append(line)
            break
        j -= 1
    return lines

"""
:lines_to_nodeList: Get a list of lines and get all the information inside and transform in a nodeList
:@param lines: The correct lines of the conversation, like Whatsapp
:return: The node_list created with the information of each line (each line -> each node)
"""
def lines_to_nodeList(lines):
    node_list = []

    for i in lines:
        node = Node()
        node.getInformation(i)
        node_list.append(node)
    
    return node_list


def del_special_char(book):
    book = ''.join(char if 32 <= ord(char) <= 191 else ' ' for char in book)
    return book


"""
:treat_lines: Get a text with any treatment, treat and transform in a nodeList
:@param text: A list of lines of Whatsapp
:@param MessageType: If the user wants to transform some message like images or pdfs with a type (to cout how many are of than)
:return: A list of nodes with the 
"""
def treat_lines(text):
    # convert every line in a single paragraph
    book = text_to_book(text)

    book = del_special_char(book)

    # With the paragraph the code construct lines
    # Each message in Whatsapp is a line in the output
    lines = construct_lines(book)

    # With every line, the code converts to a NodeList
    # Get the specific information from each line and put in a node 
    node_list = lines_to_nodeList(lines)

    

    return node_list