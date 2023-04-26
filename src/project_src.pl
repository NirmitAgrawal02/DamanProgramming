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
exp(t_exp(AE,[';'],Exp))--> ae(AE),[';'],exp(Exp).
exp(t_exp(BE,[';'],Exp))--> be(BE),[';'],exp(Exp).
exp(t_exp(Str,[';'],Exp))--> str(Str),[';'],exp(Exp).
exp(t_exp(Num,[';'],Exp))--> num(Num),[';'],exp(Exp).
exp(t_exp(ID,[';'],Exp))--> identifier(ID),[';'],exp(Exp).
exp(t_exp(AE))--> ae(AE).
exp(t_exp(BE))--> be(BE).
exp(t_exp(Str))--> str(Str).
exp(t_exp(Num))--> num(Num).
exp(t_exp(ID))--> identifier(ID).

% STRING ::= “TEMP”
str(t_str(['"'],Temp,['"']))-->['"'],temp(Temp),['"'].

% TEMP ::= CH TEMP | N TEMP | CH | N
temp(t_temp(CH,Temp))--> ch(CH),temp(Temp).
temp(t_temp(Num,Temp))--> num(Num),temp(Temp).
temp(t_temp(CH))--> ch(CH).
temp(t_temp(Num))--> num(Num).

% BE ::= SUB and BE | SUB or BE | SUB
be(t_be(Sub,['and'],BE))--> sub(Sub),['and'],be(BE).
be(t_be(Sub,['or'],BE))--> sub(Sub),['or'],be(BE).
be(t_be(Sub))--> sub(Sub).

% SUB ::= AE==AE | AE>AE | AE<AE | AE>= AE | AE<=AE | AE!= AE | not SUB | BOOL_VAL 
sub(t_sub(AE1,['=='],AE2))--> ae(AE1),['=='],ae(AE2).
sub(t_sub(AE1,['>'],AE2))--> ae(AE1),['>'],ae(AE2).
sub(t_sub(AE1,['<'],AE2))--> ae(AE1),['<'],ae(AE2).
sub(t_sub(AE1,['>='],AE2))--> ae(AE1),['>='],ae(AE2).
sub(t_sub(AE1,['<='],AE2))--> ae(AE1),['<='],ae(AE2).
sub(t_sub(AE1,['!='],AE2))--> ae(AE1),['!='],ae(AE2).
sub(t_sub(['not'],Sub))--> ['not'],sub(Sub).
sub(t_sub(Bool))--> bool_val(Bool).

% BOOL_VAL ::= true|false 
bool_val(t_boolval(['true']))--> ['true'].
bool_val(t_boolval(['false']))--> ['false'].

% AE ::= I:=T|T
ae(t_ae(ID,[':='],T))--> identifier(ID),[':='],t(T).
ae(t_ae(T))--> t.


% T::=T + T2 | T – T2 | T2
t(t_term(T,['+'],T2))--> t(T),'+',t2(T2).
t(t_term(T,['-'],T2))--> t(T),['-'],t2(T2).
t(t_term(T2))--> t2(T2).

% T2::= T2 * T3 | T2 / T3 | T3
t2(t_t2(T2,['*'],T3))--> t2(T2),['*'],t3(T3).
t2(t_t2(T2,['/'],T3))--> t2(T2),['/'],t3(T3).
t2(t_t2(T3))--> t3(T3).

% T3 ::= (AE)| I |N
t3(t_t3(['('],AE,[')']))--> ['('],ae(AE),[')'].
t3(t_t3(ID))--> identifier(ID).
t3(t_t3(Num))--> num(Num).

% I ::= CH I | CH
identifier(t_id(CH,ID))--> ch(CH),identifier(ID).
identifier(t_id(CH))--> ch(CH).

% CH ::= a | b | c | d | e | f | g | h | i | j | k | l | m | n | o | p | q | r | s | t | u | v | w | x | y | z
ch(t_ch(['a']))--> ['a'].
ch(t_ch(['b']))--> ['b'].
ch(t_ch(['c']))--> ['c'].
ch(t_ch(['d']))--> ['d'].
ch(t_ch(['e']))--> ['e'].
ch(t_ch(['f']))--> ['f'].
ch(t_ch(['g']))--> ['g'].
ch(t_ch(['h']))--> ['h'].
ch(t_ch(['i']))--> ['i'].
ch(t_ch(['j']))--> ['j'].
ch(t_ch(['k']))--> ['k'].
ch(t_ch(['l']))--> ['l'].
ch(t_ch(['m']))--> ['m'].
ch(t_ch(['n']))--> ['n'].
ch(t_ch(['o']))--> ['o'].
ch(t_ch(['p']))--> ['p'].
ch(t_ch(['q']))--> ['q'].
ch(t_ch(['r']))--> ['r'].
ch(t_ch(['s']))--> ['s'].
ch(t_ch(['t']))--> ['t'].
ch(t_ch(['u']))--> ['u'].
ch(t_ch(['v']))--> ['v'].
ch(t_ch(['w']))--> ['w'].
ch(t_ch(['x']))--> ['x'].
ch(t_ch(['y']))--> ['y'].
ch(t_ch(['z']))--> ['z'].

% N := DIG N | DIG
num(t_num(Dig,Num))--> dig(Dig),num(Num).
num(t_num(Dig))--> dig.

%DIG := 0|1|2|3|4|5|6|7|8|9
dig(t_dig(['0']))--> ['0'].
dig(t_dig(['1']))--> ['1'].
dig(t_dig(['2']))--> ['2'].
dig(t_dig(['3']))--> ['3'].
dig(t_dig(['4']))--> ['4'].
dig(t_dig(['5']))--> ['5'].
dig(t_dig(['6']))--> ['6'].
dig(t_dig(['7']))--> ['7'].
dig(t_dig(['8']))--> ['8'].
dig(t_dig(['9']))--> ['9'].









