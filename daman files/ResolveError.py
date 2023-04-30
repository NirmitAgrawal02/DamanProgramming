import subprocess
# file_path = 'C:/Users/DELL/Desktop/Nirmit/ASU/Classes/SER 502/Projects/SER502-Spring2023-Team-41-/daman files/trial.pl'
#query = 'program(P, [start, int, x, =, 8,;, if,x,==,9 , then, x, =, 7, else, x , = , 3 , fi, finish, .], []), program_eval(P,EnvOut).'

file_path = 'C:/Users\DELL\Desktop/Nirmit\ASU\Classes\SER 502\Projects\SER502-Spring2023-Team-41-\daman files/trial.pl'
query = 'heavy(Cat).'
process = subprocess.Popen(['swipl', '-s', file_path, '-g', query, '-t', 'halt'],
                           stdout=subprocess.PIPE, stderr=subprocess.PIPE, universal_newlines=True)
output, errors = process.communicate()

print(f"Output:\n{output}")

print(f"Errors:\n{errors}")
