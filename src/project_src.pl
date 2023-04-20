% DCG - Definite Clause Grammar

program(t_p(Tb)) --> block(Tb),['.'].
block(t_b(Td,Tc)) --> ['start'],declaration(Td),[';'],command(Tc),['finsih'].
declaration(t_decl(A,';',D)) --> ass_variable(A) [';']declaration.
declaration(t_decl(A,';',D)) --> decl_variable(A) [';'] declaration.
declaration(t_decl(A)) --> ass_variable(A).
declaration(t_decl(A)) --> decl_variable(A).

% ASS_VARIABLE ::= int I = N | bool I = BOOL_VAL | st I = STRING

ass_variable(t_ass_variable(['int'],Tid,['='], Tnum)) --> ['int'],identifier(Tid),['='],num(Tnum).
ass_variable(t_ass_variable(['bool'], Tid,['='],Tbval)) --> ['bool'],identifier(Tid),['='],boolean_value(Tbval).
ass_variable(t_ass_variable(['st'],Tid,['='],Tstr)) --> ['st'],identifier(Tid),['='],str(Tstr).

% DECL_VARIABLE ::= int I | bool I | st I

decl_variable(t_decl_variable(['int'],Tid)) --> ['int'],identifier(Tid).
decl_variable(t_decl_variable(['bool'],Tid)) --> ['bool'],identifier(Tid).
decl_variable(t_decl_variable(['st'],Tid)) --> ['st'],identifier(Tid).

% CMD ::= NC; CMD | NC

command(t_cmd(Tnc,Tcmd)) --> new_command(Tnc), command(Tcmd).
command(t_cmd(Tnc)) --> new_command(Tnc).

% NC ::= I = AE | if BE then CMD else CMD fi | while BE begin CMD end | for( int I = AE; BE ; AE) begin CMD end | for I in range(N,N) begin CMD end | BE? CMD : CMD | print (EXP) 

new_command(t_ncmd(Tid,['='],Tae)) --> identifier(Tid),['='],ae(Tae).
new_command(t_ncmd(['if'],Tbe,['then'],Tcmd,['else'],Tcmd1,['fi'])) --> ['if'],be(Tbe),['then'],command(Tcmd),['else'],command[Tcmd1],['fi'].
new_command(t_ncmd(['while'],Tbe,['begin'],Tcmd,['end'])) --> ['while'],be(Tbe),['begin'],command(Tcmd),['end'].
new_command(t_ncmd(['for'],['('],['int'],Tid,['='],Tae,[';'],Tbe,[';'],Tae1,[')'],['begin'],Tcmd,['end'])) --> ['for'],['('],['int'],identifier(Tid),['='],ae(Tae),[';'],be(Tbe),[';'],ae(Tae1),[')'],['begin'],command(Tcmd),['end'].
new_command(t_ncmd(['for'],Tid,['in'],['range'],['(']Tnum1,[','],Tnum2,[')'],['begin'],Tcmd,['end'])) --> ['for'],identifier(Tid),['in'],['range'],['('],num(Tnum1),[','],num(Tnum2),[')'],['begin'],command(Tcmd),['end'].
new_command(t_ncmd(Tbe,['?'],Tcmd,[':'],Tcmd1)) --> be(Tbe),['?'],command(Tcmd),[':'],command(Tcmd1).
new_command(t_ncmd(['print'],['('],Texp,[')'])) --> ['print'],['('],exp(Texp),[')'].

% EXP ::= AE;EXP | BE;EXP | STRING; EXP | N ; EXP | I; EXP|AE | BE | STRING | N | I 
exp-->ae,[';'],exp | be,[';'],exp | str,[';'],exp | num,[';'],exp | identifier,[';'],exp | ae | be | str | num | identifier.

% STRING ::= “TEMP”
str-->['"'],temp,['"'].

% TEMP ::= CH TEMP | N TEMP | CH | N
temp-->ch,temp | num,temp | ch | num.

% BE ::= SUB and BE | SUB or BE | SUB
be-->sub,['and'],be | sub,['or'],be | sub.

% SUB ::= AE==AE | AE>AE | AE<AE | AE>= AE | AE<=AE | AE!= AE | not SUB | BOOL_VAL 
sub-->ae,['=='],ae | ae,['>'],ae | ae,['<'],ae | ae,['>='],ae | ae,['<='],ae | ae,['!='],ae | ['not'],sub | bool_val.

% BOOL_VAL ::= true|false 
bool_val-->['true'] | ['false'].

% AE ::= I:=T|T
ae-->identifier,[':='],t | t.


% T::=T + T2 | T – T2 | T2
t-->t,'+',t2 | t,['-'],t2 | t2.

% T2::= T2 * T3 | T2 / T3 | T3
t2-->t2,['*'],t3 | t2,['/'],t3 | t3.

% T3 ::= (AE)| I |N
t3-->['('],ae,[')'] | identifier | num.

% I ::= CH I | CH
identifier-->ch,identifier | ch.

% CH ::= a | b | c | d | e | f | g | h | i | j | k | l | m | n | o | p | q | r | s | t | u | v | w | x | y | z
ch-->['a'] | ['b'] | ['c'] | ['d'] | ['e'] | ['f'] | ['g'] | ['h'] | ['i'] | ['j'] | ['k'] | ['l'] | ['m'] | ['n'] | ['o'] | ['p'] | ['q'] | ['r'] | ['s'] | ['t'] | ['u'] | ['v'] | ['w'] | ['x'] | ['y'] | ['z'].

% N := DIG N | DIG
num--> dig,num | dig.

%DIG := 0|1|2|3|4|5|6|7|8|9
dig-->['0'] | ['1'] | ['2'] | ['3'] | ['4'] | ['5'] | ['6'] | ['7'] | ['8'] | ['9'].









