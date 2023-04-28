from tokenize import tokenize, untokenize
from io import BytesIO

keywords = ["start","finish","int","bool","st","if","then","else","fi","while","begin","end","for","in","range","print","and","or","true","false"]
operators = ["+", "-", "*", "/", "=", ">", "<", "!", "?", ":"]
arithmetic_assignment = ["==","!=","<=",">="]
separators = ["(", ")", "{", "}", ","]

def lexical_analyzer(file):
    if file[-5:] != "daman":
        print("Unsupported file extension")
        return
    final_op = "["
    process = open(file, 'r').read()
    value = tokenize(BytesIO(process.encode('utf-8')).readline)
    listValue = []
    for tokenNum, val, _, _, _ in value:
        if len(val) == 0:
            continue
        else:
            if val == "\n" or val == " " or val == "\t":
                continue
            else:
                if val == "[":
                    listValue.append(val)
                elif val == "]":
                    listValue.append(val)
                    for val in listValue:
                        final_op += val
                        final_op += ", "
                    listValue = []
                else:
                    if val in keywords or val in operators or val == ";":
                        final_op += val
                        final_op += ", "
                    elif val in separators:
                        final_op += "'"
                        final_op += val
                        final_op += "', "
                    elif val.startswith("'"):
                        temp = val[1:-1]
                        final_op += ("'" + temp + "', ")
                    elif val.startswith('"'):
                        temp = val[1:-1]
                        final_op += ('"' + temp + '", ')
                    elif val in arithmetic_assignment:
                        final_op += val
                        final_op += ", "
                    elif val == ".":
                        final_op += val + ","
    final_op = final_op[:-2]
    final_op += "]"
    print(final_op)
    return final_op


if __name__ == "__main__":
    x = input("Enter the name of the file ")
    lexical_analyzer(x)