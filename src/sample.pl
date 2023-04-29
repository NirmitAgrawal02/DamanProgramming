% Include the source code file
:- include('/Users/akshatbakliwal/Desktop/Bansal/502/Project/SER502-Spring2023-Team-41--1/src/project_src.pl').

% Define the test cases
test_case(1, [start, int, x, =, 8,;, if,x,==,9 , then, x, =, 7, else, x , = , 3 , fi, finish, .], EnvOut).
test_case(2, [start, int, x, =, 8,;, if,x,==,9 , then, x, =, 7, else, x , = , 3 , fi, finish, .], EnvOut).
test_case(3, [start, int, x, =, 8,;, if,x,==,9 , then, x, =, 7, else, x , = , 3 , fi, finish, .], EnvOut).

% add more test cases as needed

% Define the run/1 predicate
run(Case) :-
    test_case(Case, Tokens, Env),
    write('\nTest case '), write(Case), write(':\n\n'),
    (current_predicate(program/3), current_predicate(program_eval/2) ->
        findall((Z), (program(P, Tokens, []), (program_eval(P, Env)), Ans_Set), forall(member(Ans, Ans_Set), (write(Ans),nl))) ;
        write('\n*** Missing either program/3 or program_eval/4 ***\n\n')).

run :-
    findall((Case), run(Case), _),
    halt.