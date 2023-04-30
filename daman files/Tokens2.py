from tokenize import tokenize, untokenize
from io import BytesIO
from pyswip import Prolog

prolog = Prolog()
defined_terms = ["start", "finish", "int", "bool", "st", "if", "then", "else", "fi", "while", "begin", "end", "for", "in", "range", "print",
                 "and", "or", "true", "false", "not", "+", "-", "*", "/", "=", ">", "<", "!", "?", ":", "==", "!=", "<=", ">=", "(", ")",  ",", ".", ";"]

prolog.consult("src/project_src.pl")


def get_tokens(file):
    ext = file.split('.')
    print(ext)
    if ext[1] != "daman":
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
                if val in defined_terms:
                    final_op += "'"+val+"'"
                    final_op += ", "
                elif val.startswith('"'):
                    temp = val[1:-1]
                    final_op += ('"' + temp + '", ')
                elif val == ".":
                    final_op += "'.',"
                elif val.isdigit():
                    final_op += val + ","
                elif val.isalpha():
                    final_op += "'"+val+"',"
    final_op = final_op[:-1]
    final_op += "]"
    print(final_op)

    return final_op


def evaluator(tok):
    res = ""
    for sol in prolog.query("program(P,"+tok+",[]."):
        res = sol["P"]
    if not res:
        print("No Tree")
        return None
    res = res.replace("b'", "'")
    for fin in prolog.query("program_eval("+res+",EnvOut)."):
        pass
    return fin


x = input("Enter the name of the file ")
evaluator(get_tokens(x))
