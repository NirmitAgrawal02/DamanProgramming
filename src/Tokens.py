from tokenize import tokenize, untokenize
from io import BytesIO

KEYWORDS = ["start","finish","int","bool","st","if","then","else","fi","while","begin","end","for","in","range","print","and","or","true","false","not"]
OPERATORS = ["+", "-", "*", "/", "=", ">", "<", "!", "?", ":"]
ARITHMETIC_ASSIGNMENT = ["==","!=","<=",">="]
SEPARATORS = ["(", ")",  ","]

def get_tokens(file):
    ext = file.split('.')
    print(ext)
    if ext[1] != "daman":
        print("Unsupported file extension")
        return
    
    final_op = "["

    with open(file, 'r') as f:
        value = tokenize(BytesIO(f.read().encode('utf-8')).readline)

    for tokenNum, val, _, _, _ in value:
        if len(val) == 0:
            continue
        elif val == "\n" or val == " " or val == "\t":
            continue
        elif val in KEYWORDS or val in OPERATORS or val == ";":
            final_op += f"'{val}', "
        elif val in SEPARATORS:
            final_op += f"'{val}', "
        elif val.startswith("'") or val.startswith('"'):
            temp = val[1:-1]
            final_op += f"'{temp}', "
        elif val in ARITHMETIC_ASSIGNMENT:
            final_op += f"'{val}', "
        elif val == ".":
            final_op += "'.',"
        elif val.isdigit():
            final_op += f"{val},"
        elif val.isalpha():
            final_op += f"'{val}',"

    final_op = final_op[:-1]
    final_op += "]"
    print(final_op)
    return final_op


if __name__ == "__main__":
    x = input("Enter the name of the file: ")
    get_tokens(x)
